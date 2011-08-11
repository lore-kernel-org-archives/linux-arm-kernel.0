From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 11 Aug 2011 13:55:14 +0900
Subject: [PATCH 0/4] ARM: EXYNOS4: Support generic Power domain framework for
	EXYNOS4210
Message-ID: <4E4360B2.2060508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch set use the generic Power domain Framework instead of
power domain code depend of Samsung SoC.

Chanwoo Choi (4):
  ARM: EXYNOS4: Support for generic I/O power domains on EXYNOS4210
  ARM: EXYNOS4: Support for generic Clock manipulation PM callbacks
  ARM: EXYNOS4: Delete the power-domain code depend on Samsung SoC
  ARM: EXYNOS4: Add power domain to use generic Power domain Framework

 arch/arm/mach-exynos4/Kconfig                      |   10 +-
 arch/arm/mach-exynos4/Makefile                     |    4 +-
 arch/arm/mach-exynos4/dev-pd.c                     |  139 --------------
 arch/arm/mach-exynos4/include/mach/pm-exynos4210.h |   52 ++++++
 arch/arm/mach-exynos4/include/mach/regs-clock.h    |    8 +
 arch/arm/mach-exynos4/mach-nuri.c                  |   21 ++-
 arch/arm/mach-exynos4/mach-smdkc210.c              |   26 ++-
 arch/arm/mach-exynos4/mach-smdkv310.c              |   23 ++-
 arch/arm/mach-exynos4/mach-universal_c210.c        |   21 ++-
 arch/arm/mach-exynos4/pm-exynos4210.c              |  189 ++++++++++++++++++++
 arch/arm/mach-exynos4/pm-runtime.c                 |   56 ++++++
 arch/arm/plat-samsung/Kconfig                      |    8 -
 arch/arm/plat-samsung/Makefile                     |    4 -
 arch/arm/plat-samsung/include/plat/pd.h            |   30 ---
 arch/arm/plat-samsung/pd.c                         |   95 ----------
 15 files changed, 377 insertions(+), 309 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/dev-pd.c
 create mode 100644 arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
 create mode 100644 arch/arm/mach-exynos4/pm-exynos4210.c
 create mode 100644 arch/arm/mach-exynos4/pm-runtime.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/pd.h
 delete mode 100644 arch/arm/plat-samsung/pd.c
