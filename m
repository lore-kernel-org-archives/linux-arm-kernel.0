From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Feb 2017 15:29:03 +0100
Subject: [PATCH] iommu: mtk: remove bogus 'select' statements
Message-ID: <20170202142921.3467470-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mediatek IOMMU driver enables some drivers that it does not directly
rely on, and that causes a warning for build testing:

warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_VDECSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)
warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)
warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_MMSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)

This removes the select statements.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bb537d06d319..8b6fd8928819 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -352,9 +352,6 @@ config MTK_IOMMU_V1
 	select IOMMU_API
 	select MEMORY
 	select MTK_SMI
-	select COMMON_CLK_MT2701_MMSYS
-	select COMMON_CLK_MT2701_IMGSYS
-	select COMMON_CLK_MT2701_VDECSYS
 	help
 	  Support for the M4U on certain Mediatek SoCs. M4U generation 1 HW is
 	  Multimedia Memory Managememt Unit. This option enables remapping of
-- 
2.9.0
