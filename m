From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:20:22 -0600
Subject: [PATCH] iommu: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
Message-ID: <1374013222-4856-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
This will reduce the number of configurations that need to be supported
by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 820d85c..0da7938 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -148,7 +148,7 @@ config OMAP_IOMMU_DEBUG
 
 config TEGRA_IOMMU_GART
 	bool "Tegra GART IOMMU Support"
-	depends on ARCH_TEGRA_2x_SOC
+	depends on ARCH_TEGRA
 	select IOMMU_API
 	help
 	  Enables support for remapping discontiguous physical memory
-- 
1.8.1.5
