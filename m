From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Nov 2016 16:28:13 +0100
Subject: [PATCH] iommu: mtk: add common-clk dependency
Message-ID: <20161116152837.3508723-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the MT2701 clock driver was added, we get a harmless warning for
the iommu driver that selects it, when compile-testing without
COMMON_CLK.

warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK)

Adding a dependency on COMMON_CLK avoids the warning.

Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ee54d71c7eb..bb537d06d319 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -346,7 +346,7 @@ config MTK_IOMMU
 
 config MTK_IOMMU_V1
 	bool "MTK IOMMU Version 1 (M4U gen1) Support"
-	depends on ARM
+	depends on ARM && COMMON_CLK
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
-- 
2.9.0
