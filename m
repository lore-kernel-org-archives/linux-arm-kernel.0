From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 18 Feb 2016 15:12:47 +0100
Subject: [PATCH v2 00/13] SYSMMU driver update and support for Exynos 5433
Message-ID: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
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

Changelog:
v2:
- added support for multiple calls of device_attach (without detach),
  needed for default domain handling in iommu core (patch no 13), more
  information in the following thread:
  https://lists.linaro.org/pipermail/linaro-mm-sig/2016-February/004625.html
- fixed support for SYSMMU controllers with bogus version register value
  (patch no 9)

v1: http://www.spinics.net/lists/arm-kernel/msg483531.html
- initial version

Patch summary:

Marek Szyprowski (13):
  iommu: exynos: rework iommu group initialization
  iommu: exynos: add support for IOMMU_DOMAIN_DMA domain type
  iommu: exynos: remove ARM-specific cache flush interface
  iommu: exynos: simplify master clock operations
  iommu: exynos: refactor code (no direct register access)
  iommu: exynos: refactor fault handling code
  iommu: exynos: refactor init config code
  iommu: exynos: unify code for fldp cache invalidation
  iommu: exynos: add support for SYSMMU controller with bogus version
    reg
  iommu: exynos: update device tree documentation
  iommu: exynos: add support for v5 SYSMMU
  iommu: exynos: add Maintainers entry for Exynos SYSMMU driver
  iommu: exynos: support multiple attach_device calls

 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  22 +-
 MAINTAINERS                                        |   6 +
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/exynos-iommu.c                       | 598 ++++++++++++---------
 4 files changed, 372 insertions(+), 256 deletions(-)

-- 
1.9.2
