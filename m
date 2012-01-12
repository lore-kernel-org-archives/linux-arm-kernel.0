From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jan 2012 11:31:09 -0600
Subject: [PATCH v2 0/7] BSYM macro removal and secondary startup fixes
Message-ID: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

BSYM macro usage is generally unnecessary in .c files if assembly functions
are properly annotated with ENTRY/ENDPROC. BSYM combined with properly
annotated assembly functions or C functions generates a wrong address
on Thumb2 builds causing secondary cores to fail to boot.

Tested Thumb2 SMP boot on highbank and imx6.

Changes in v2:
- Add missing ENDPROC annotation for all secondary startup functions.
- Use Pawel's patch for ARM boards instead.

Rob

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
 arch/arm/mach-exynos/headsmp.S    |    1 +
 arch/arm/mach-exynos/platsmp.c    |    5 ++---
 arch/arm/mach-highbank/highbank.c |    3 +--
 arch/arm/mach-imx/src.c           |    3 +--
 arch/arm/mach-msm/headsmp.S       |    1 +
 arch/arm/mach-realview/platsmp.c  |    3 +--
 arch/arm/mach-ux500/headsmp.S     |    1 +
 arch/arm/mach-vexpress/platsmp.c  |    4 +---
 arch/arm/plat-versatile/headsmp.S |    1 +
 10 files changed, 12 insertions(+), 14 deletions(-)

-- 
1.7.5.4
