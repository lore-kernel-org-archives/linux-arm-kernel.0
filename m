From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Wed, 11 Dec 2013 16:25:14 +0545
Subject: [PATCH 0/2] Add initial support of PMU and CMU for exynos5260
Message-ID: <1386758416-31065-1-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1) Added initial PMU support for exynos5260

2) Added exynos5260_iodesc for mapping 5260 specific SFRs. We modified
exynos5_map_io so that in case of exynos5260 only exynos5260_iodesc can
be initialized.

3) Added new macros for WAKEUP MASK for 5260, and modified exynos_pm_drvinit
accordingly.

4) Adds CMU virtual addresses for exynos5260.

rebased on kgene tree for-next branch
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
and on top of rahul's patches for basic support of exynos5260
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg24573.html

Vikas Sajjan (1):
  ARM: EXYNOS: Add initial support of PMU for Exynos5260

Young-Gun Jang (1):
  ARM: EXYNOS: Add CMU virtual addresses for exynos5260

 arch/arm/mach-exynos/common.c                  | 154 ++++++++++++++++-
 arch/arm/mach-exynos/common.h                  |   5 +
 arch/arm/mach-exynos/include/mach/map.h        |  31 ++++
 arch/arm/mach-exynos/include/mach/regs-clock.h |  17 ++
 arch/arm/mach-exynos/include/mach/regs-pmu.h   | 221 +++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c                      |  33 +++-
 arch/arm/mach-exynos/pmu.c                     | 140 ++++++++++++++++
 arch/arm/plat-samsung/include/plat/map-s5p.h   |  30 ++++
 8 files changed, 620 insertions(+), 11 deletions(-)

-- 
1.7.12.4
