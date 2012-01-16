From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jan 2012 09:19:52 -0600
Subject: [PULL] Thumb2 BSYM fixes and cleanup
Message-ID: <4F144018.7080104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull this fix/cleanup for SMP secondary boot on Thumb2 kernels.
This has been tested on highbank, imx, and versatile. I've gotten no
feedback for other platforms. This can wait for after rc1 if you prefer.

Pawel's patch is also in the VExpress DT support series, but it looks
like that is not going into 3.3 so I've included it here.

Rob

The following changes since commit 805a6af8dba5dfdd35ec35dc52ec0122400b2610:

  Linux 3.2 (2012-01-04 15:55:44 -0800)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git fixes-for-arm-soc

Pawel Moll (1):
      ARM: versatile: Add missing ENDPROC to headsmp.S

Rob Herring (6):
      ARM: msm: Add missing ENDPROC to headsmp.S
      ARM: ux500: add missing ENDPROC to headsmp.S
      ARM: exynos: remove incorrect BSYM usage
      ARM: imx: remove incorrect BSYM usage
      ARM: highbank: remove incorrect BSYM usage
      ARM: make BSYM macro assembly only

 arch/arm/include/asm/unified.h    |    4 ++--
 arch/arm/mach-exynos/headsmp.S    |    2 ++
 arch/arm/mach-exynos/platsmp.c    |    5 ++---
 arch/arm/mach-highbank/highbank.c |    3 +--
 arch/arm/mach-imx/src.c           |    3 +--
 arch/arm/mach-msm/headsmp.S       |    1 +
 arch/arm/mach-realview/platsmp.c  |    3 +--
 arch/arm/mach-ux500/headsmp.S     |    2 ++
 arch/arm/mach-vexpress/platsmp.c  |    4 +---
 arch/arm/plat-versatile/headsmp.S |    1 +
 10 files changed, 14 insertions(+), 14 deletions(-)
