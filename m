From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 16 Feb 2016 15:56:53 +0100
Subject: [PATCH 00/11] SYSMMU driver update and support for Exynos 5433
Message-ID: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset updates Exynos SYSMMU (IOMMU) driver to make use of the
new features in the IOMMU core (support for IOMMU_DOMAIN_DMA) and adds
support for SYSMMU v5 controllers, which are available in Samsung Exynos
5433 SoCs. The driver has been also updated to compile and work on ARM64
architecture.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (11):
  iommu: exynos: rework iommu group initialization
  iommu: exynos: add support for IOMMU_DOMAIN_DMA domain type
  iommu: exynos: remove ARM-specific cache flush interface
  iommu: exynos: simplify master clock operations
  iommu: exynos: refactor code (no direct register access)
  iommu: exynos: refactor fault handling code
  iommu: exynos: refactor init config code
  iommu: exynos: unify code for fldp cache invalidation
  iommu: exynos: update device tree documentation
  iommu: exynos: add support for v5 SYSMMU
  iommu: exynos: add Maintainers entry for Exynos SYSMMU driver

 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  22 +-
 MAINTAINERS                                        |   6 +
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/exynos-iommu.c                       | 514 ++++++++++++---------
 4 files changed, 318 insertions(+), 226 deletions(-)

-- 
1.9.2
