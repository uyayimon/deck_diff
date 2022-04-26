# https://drive.google.com/drive/u/0/folders/1A51hoLwagupYIzFJPW3WGPlCZeu5Sz5q
#!/bin/bash

NOW=$(date "+%%m%d_%H%M%S")
ORIGINAL_FILE="original_list.txt"
SORTED_FILE="result/sorted_file${NOW}.txt"
RESULT_FILE="result/result${NOW}.txt"

RemoveTempFiles() {
  rm -f tmp/diff*.txt
  rm -f tmp/tmp*.txt
}

DivideAndSort() {
  case "$1" in
    "${ORIGINAL_FILE}")
      local string="${NOW}";;
    "${LAST_SORTED_FILE}")
      local string="last";;
  esac

sed -n '/#Main/,/#Extra/p' "$1" | sed -e '1d;$d' | sort -f \
  > "tmp/tmpl_${string}.txt"
sed -n '/#Extra/,/!Side/p' "$1" | sed -e '1d;$d' | sort -f \
  > "tmp/tmp2_${string}.txt"
sed -n '/!Side/,/$p/p' "$1" | sed -e '1d' | sort -f \
  > "tmp/tmp3_${string}.txt"
}

if [ $(ls result/sorted file* | wc -l) -ne 0 ]; then
  LAST_SORTED_FILE=$(ls -rt result/sorted_file* | tail -n 1)
  DivideAndSort "${LAST_SORTED_FILE}"
fi

DivideAndSort "${ORIGINAL_FILE}"


for i in $(seq 3)
do
  LATEST_TMP="tmp/tmp${i}_${NOW}.txt"
  LAST_TMP=
done
