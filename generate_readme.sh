#!/usr/bin/env zsh
README_BASE=$(cat <<EOF
# varenc's mostly macOS zsh completions
my personal zsh completions from various sources. Some generated, some found elsewhere, some hand written.
EOF
)
README_BASE+="\n\n## Completions\n"

# get all completions and then list them in last modified order
all_completions=($(ls -tr $(git ls-tree --full-tree -r --name-only HEAD | grep '^_') | sed 's/^_//g'))
for completion in "${all_completions[@]}"; do
    if [[ $completion == 'retrieve_mac_apps' ]] ; then
        README_BASE+=" - \`_${completion}\` (to fix a bug in Apple's \`open -a ...\` completion definition\n"
    else
        README_BASE+=" - \`$completion\`\n"
    fi
done

echo -n "$README_BASE" > README.md
echo "Wrote README.md! Diff:"
git diff --color=always README.md | cat
