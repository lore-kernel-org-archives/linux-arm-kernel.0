From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 25 Oct 2011 19:35:23 +0900
Subject: [PATCH 0/3 v3] ARM: EXYNOS4: Support generic Power domain framework
	for EXYNOS4 series
Message-ID: <4EA690EB.2050700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch set use the generic Power domain framework instead of
power domain code depend on samsung SoC.

It is based 'for-next' branch on git://github/com/kgene/linux-samsung.git.

I refer to the following patch to implement what configure the clock-gating
control register for block to turn off/on:
http://git.infradead.org/users/kmpark/linux-2.6-samsung/commit/39a81876d034dcbdc2a4c4c4b847b3b49e38870c

Patch 1/3 has renamed function and support power domain for EXYNOS4210/4212
Patch 2/3 has just one calling to initalize the poewr domain of EXYNOS4210/4212
Patch 3/3 has no changes

Chanwoo Choi (3):
  ARM: EXYNOS4: Support for generic I/O power domains on
    EXYNOS4210/4212
  ARM: EXYNOS4: Use generic power domain on EXYNOS4210/4212
  ARM: EXYNOS4: Delete the power domain code depend on samsung SoC

 arch/arm/mach-exynos4/Kconfig                   |    7 +-
 arch/arm/mach-exynos4/Makefile                  |    2 +-
 arch/arm/mach-exynos4/dev-pd.c                  |  139 -------------
 arch/arm/mach-exynos4/include/mach/pm-exynos4.h |   50 +++++
 arch/arm/mach-exynos4/include/mach/regs-clock.h |    9 +
 arch/arm/mach-exynos4/include/mach/regs-pmu.h   |    2 +
 arch/arm/mach-exynos4/mach-armlex4210.c         |    3 +
 arch/arm/mach-exynos4/mach-nuri.c               |   24 ++--
 arch/arm/mach-exynos4/mach-origen.c             |   19 +--
 arch/arm/mach-exynos4/mach-smdk4x12.c           |    3 +
 arch/arm/mach-exynos4/mach-smdkv310.c           |   17 +-
 arch/arm/mach-exynos4/mach-universal_c210.c     |   26 ++--
 arch/arm/mach-exynos4/pm-exynos4.c              |  237 +++++++++++++++++++++++
 arch/arm/plat-samsung/Kconfig                   |    8 -
 arch/arm/plat-samsung/Makefile                  |    4 -
 arch/arm/plat-samsung/include/plat/pd.h         |   30 ---
 arch/arm/plat-samsung/pd.c                      |   95 ---------
 17 files changed, 344 insertions(+), 331 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/dev-pd.c
 create mode 100644 arch/arm/mach-exynos4/include/mach/pm-exynos4.h
 create mode 100644 arch/arm/mach-exynos4/pm-exynos4.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/pd.h
 delete mode 100644 arch/arm/plat-samsung/pd.c
