From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:47 +0300
Subject: [PATCH v2 12/22] iommu/tegra: smmu: Select ARM_DMA_USE_IOMMU in
 Kconfig
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-13-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMMU expects ARM_DMA_USE_IOMMU to be enabled to use DMA mapping API by
default.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 820d85c..cd9318b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -160,6 +160,7 @@ config TEGRA_IOMMU_SMMU
 	bool "Tegra SMMU IOMMU Support"
 	depends on ARCH_TEGRA && TEGRA_AHB
 	select IOMMU_API
+	select ARM_DMA_USE_IOMMU
 	help
 	  Enables support for remapping discontiguous physical memory
 	  shared with the operating system into contiguous I/O virtual
-- 
1.7.9.5
