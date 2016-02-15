From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Feb 2016 10:15:33 +0100
Subject: [GIT PULL] plat-versatile clock.c and generic clkdev.h
Message-ID: <CACRpkdbJPPR8jADF1p++w60jZre3tpCAECsaqkzAk4-Y4+N-SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

these are Stephen Boyds changes to remove a stale clock implementation
and move to the generic clkdev.h that I queued at Arnd's request, it turns
out I will not have any busines changing stuff in arch/arm/plat-versatile
for this merge window (however a few changes around mach-*) so
this can be pulled in separately.

Please pull this in!

Yours,
Linus Walleij


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/plat-versatile-cleanup

for you to fetch changes up to 34d2f4d3a4d6a6b204ebfd12d1d2c159360d41a4:

  ARM: Use generic clkdev.h header (2016-02-10 09:22:35 +0100)

----------------------------------------------------------------
plat-versatile cleanup:
- Removes the clock.c in plat-versatile that is no longer used
- Move ARM to use the generic clockdev.h header

----------------------------------------------------------------
Stephen Boyd (2):
      ARM: plat-versatile: Remove unused clock.c file
      ARM: Use generic clkdev.h header

 arch/arm/include/asm/Kbuild      |  1 +
 arch/arm/include/asm/clkdev.h    | 31 -----------------
 arch/arm/plat-versatile/Kconfig  |  3 --
 arch/arm/plat-versatile/Makefile |  1 -
 arch/arm/plat-versatile/clock.c  | 74 ----------------------------------------
 5 files changed, 1 insertion(+), 109 deletions(-)
 delete mode 100644 arch/arm/include/asm/clkdev.h
 delete mode 100644 arch/arm/plat-versatile/clock.c
