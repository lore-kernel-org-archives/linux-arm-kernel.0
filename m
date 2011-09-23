From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 23 Sep 2011 21:01:44 +0900
Subject: [PATCH 0/3] iommu/exynos: Add iommu driver for Exynos4 SoCs
Message-ID: <1316779307-2567-1-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

This patch set enhances System MMU platform device definitions of Exynos
SoC platforms, adds the implementation of IOMMU API as well as and moves
Syste MMU driver to the drivers/iommu directory.

The IOMMU driver also implements fault handler that Ohad Ben-Cohen has
suggeested and iommu_ops per-bus_type that Joerg Roedel suggests.

CONFIG_S5P_SYSTEM_MMU is removed because it is replaceable
with CONFIG_EXYNOS4_IOMMU.

Diffstat:

arch/arm/mach-exynos4/Kconfig               |    2 -
arch/arm/mach-exynos4/clock.c               |   43 +-
arch/arm/mach-exynos4/dev-sysmmu.c          |  281 +++-------
arch/arm/mach-exynos4/include/mach/irqs.h   |    1 -
arch/arm/mach-exynos4/include/mach/map.h    |    1 -
arch/arm/mach-exynos4/include/mach/sysmmu.h |   96 ++--
arch/arm/mach-exynos4/mach-armlex4210.c     |   24 +-
arch/arm/mach-exynos4/mach-smdkv310.c       |   28 +-
arch/arm/plat-s5p/Kconfig                   |    8 -
arch/arm/plat-s5p/Makefile                  |    1 -
arch/arm/plat-s5p/include/plat/sysmmu.h     |   95 ---
arch/arm/plat-s5p/sysmmu.c                  |  312 ----------
drivers/iommu/Kconfig                       |   14 +
drivers/iommu/Makefile                      |    1 +
drivers/iommu/exynos_iommu.c                |  859 +++++++++++++++++++++++++++
15 files changed, 1084 insertions(+), 682 deletions(-)
