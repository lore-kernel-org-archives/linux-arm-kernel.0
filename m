From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 04 Nov 2016 09:09:20 +0530
Subject: [PATCH 0/4] Add SCU device node support for Exynos4
Message-ID: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does some cleanup for Exynos4 SoC based boards.
We are currently statically mapping SCU SFRs in mach-exynos/exynos.c
which can be avoided and related dependencies can be removed by introduction
of SCU device node. 
  
This patch series is tested on Exynos4210 based Origen board for SMP boot.

Pankaj Dubey (4):
  ARM: EXYNOS: Remove smp_init_cpus hook from platsmp.c
  ARM: dts: exynos: Add SCU device node to exynos4.dtsi
  ARM: EXYNOS: Remove static mapping of SCU SFR
  ARM: EXYNOS: Remove unused soc_is_exynos{4,5}

 arch/arm/boot/dts/exynos4.dtsi               |  5 +++
 arch/arm/mach-exynos/common.h                |  5 ---
 arch/arm/mach-exynos/exynos.c                | 22 -------------
 arch/arm/mach-exynos/include/mach/map.h      |  2 --
 arch/arm/mach-exynos/platsmp.c               | 49 +++++++---------------------
 arch/arm/mach-exynos/pm.c                    | 14 ++++++--
 arch/arm/mach-exynos/suspend.c               | 15 ++++++---
 arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ---
 8 files changed, 38 insertions(+), 78 deletions(-)

-- 
2.7.4
