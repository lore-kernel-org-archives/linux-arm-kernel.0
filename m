From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:01 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.3
Message-ID: <cover.1436509680.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup for v4.3.

Amongst other things it removes almost 7000 lines of code :)


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v4.3

for you to fetch changes up to 20834a406ee20b57c796f9911f06600b71c75788:

  ARM: shmobile: timer: r8a73a4 and r8a7790 are multi-platform only (2015-07-06 09:29:46 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v4.3

* Remove non-multiplatform code from timer
* Remove CONFIG_ARCH_SHMOBILE_MULTI check in setup-rcar-gen2.c
  as it is always true
* Remove legacy (non-multiplatform) support for both sh73a0/kzm9g and
  r8a7740/armadillo800eva
* Move to_rmobile_pd from header to source file where it is used
* Use BIT() macro instead of open coding in r-mobile PM code
* r8a7779: Remove usage of GENPD_FLAG_PM_CLK flag which has no effect

----------------------------------------------------------------
Geert Uytterhoeven (16):
      ARM: shmobile: R-Mobile: Move to_rmobile_pd from header to source file
      ARM: shmobile: R-Mobile: Use BIT() macro instead of open coding
      ARM: shmobile: r8a7779: Remove GENPD_FLAG_PM_CLK flag
      ARM: shmobile: Remove legacy board code for KZM-A9-GT
      ARM: shmobile: Remove legacy kzm9g_defconfig
      ARM: shmobile: Drop sh73a0-kzm9g.dtb for legacy builds
      ARM: shmobile: Remove legacy SoC code for SH-Mobile AG5
      ARM: shmobile: Remove legacy board code for Armadillo-800 EVA
      ARM: shmobile: Remove legacy armadillo800eva_defconfig
      ARM: shmobile: Drop r8a7740-armadillo800eva.dtb for legacy builds
      ARM: shmobile: Remove legacy SoC code for R-Mobile A1
      ARM: shmobile: Remove unused dma-register.h
      ARM: shmobile: R-Mobile: Remove legacy PM Domain code
      ARM: shmobile: Remove obsolete zboot support
      ARM: shmobile: R-Car Gen2: CONFIG_ARCH_SHMOBILE_MULTI is always set
      ARM: shmobile: timer: r8a73a4 and r8a7790 are multi-platform only

 MAINTAINERS                                        |    2 -
 arch/arm/boot/compressed/Makefile                  |    4 -
 arch/arm/boot/compressed/head-shmobile.S           |   71 -
 arch/arm/boot/dts/Makefile                         |    4 +-
 arch/arm/configs/armadillo800eva_defconfig         |  162 ---
 arch/arm/configs/kzm9g_defconfig                   |  154 ---
 arch/arm/mach-shmobile/Kconfig                     |   33 -
 arch/arm/mach-shmobile/Makefile                    |    8 +-
 arch/arm/mach-shmobile/Makefile.boot               |    2 -
 arch/arm/mach-shmobile/board-armadillo800eva.c     | 1365 --------------------
 arch/arm/mach-shmobile/board-kzm9g.c               |  916 -------------
 arch/arm/mach-shmobile/clock-r8a7740.c             |  675 ----------
 arch/arm/mach-shmobile/clock-sh73a0.c              |  752 -----------
 arch/arm/mach-shmobile/dma-register.h              |   84 --
 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt |  410 ------
 arch/arm/mach-shmobile/include/mach/zboot.h        |   19 -
 arch/arm/mach-shmobile/include/mach/zboot_macros.h |  108 --
 arch/arm/mach-shmobile/intc-sh73a0.c               |  337 -----
 arch/arm/mach-shmobile/pm-r8a7740.c                |  129 --
 arch/arm/mach-shmobile/pm-r8a7779.c                |    1 -
 arch/arm/mach-shmobile/pm-rmobile.c                |   49 +-
 arch/arm/mach-shmobile/pm-rmobile.h                |   30 -
 arch/arm/mach-shmobile/pm-sh73a0.c                 |   32 -
 arch/arm/mach-shmobile/r8a7740.h                   |   58 -
 arch/arm/mach-shmobile/setup-r8a7740.c             |  678 +---------
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |    2 -
 arch/arm/mach-shmobile/setup-sh73a0.c              |  739 +----------
 arch/arm/mach-shmobile/sh73a0.h                    |   83 --
 arch/arm/mach-shmobile/smp-sh73a0.c                |    8 -
 arch/arm/mach-shmobile/timer.c                     |   12 -
 30 files changed, 15 insertions(+), 6912 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/head-shmobile.S
 delete mode 100644 arch/arm/configs/armadillo800eva_defconfig
 delete mode 100644 arch/arm/configs/kzm9g_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-armadillo800eva.c
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7740.c
 delete mode 100644 arch/arm/mach-shmobile/clock-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/dma-register.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt
 delete mode 100644 arch/arm/mach-shmobile/include/mach/zboot.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/zboot_macros.h
 delete mode 100644 arch/arm/mach-shmobile/intc-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7740.c
 delete mode 100644 arch/arm/mach-shmobile/pm-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/r8a7740.h
