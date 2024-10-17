#!/bin/sh

ls | while read line; do
	test -f $line/format || continue
	counter=0
	rm $line/format.db 2>/dev/null || true
	cat $line/format | tr ':' ' ' | while read fmt; do
		test ! -z "$fmt" || continue
		echo "-p\"$fmt\""
		counter="`echo $counter + 1 | bc`"
	done | xargs -I {} qhash {} $line/format.db
done
