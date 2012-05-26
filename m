From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 May 2012 00:22:30 -0700
Subject: [GIT PULL 0/8] Second batch of arm-soc branches for 3.5
Message-ID: <1338016958-7887-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This is the second and last large set of arm-soc branches for the 3.5
merge window. There will likely be a couple of small pull requests next
week (and thereafter fixes).

Descriptions of each branch are in the corresponding request.

Most of them have some trivial merge conflicts with earlier branches or
other code that has gone in since they were staged. Notes below are for
the slightly trickier cases. Just like with the last batch I've pushed
up resolved/<tagname> branches with proposed resolutions if you want
to compare.

cleanup2 branch:
omap_init_clocksource_32k(): Keep the version from this branch but add
in the register_persistent_clock() addition from bd0493e.

clock branch:
An awkward add/remove conflict in mach-kirkwood/common.c. Code is removed
here that was fixed in one of our earlier branches. The right thing to
do is to still just remove the code.

dt2 branch:
gpio-mxs.c: Keep the (port) side but change false -> 0 on the last arg.

soc2 branch:
gpio-samsung.c: Slightly awkward move/change conflict. Essentially
re-apply the second hunk of f10590c9 in the moved function
(exynos5_gpiolib_init()).

cleanup-initcall branch:
Trivial conflict deltas and a deleted file conflict. The removed file
should remain removed.


Thanks!

-Olof
