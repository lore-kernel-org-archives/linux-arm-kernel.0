From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 29 Feb 2016 11:13:39 +0000
Subject: [PATCH] iommu/dma: Fix NEED_SG_DMA_LENGTH dependency
Message-ID: <189f8d7a6b1598108dc8e9f1777c67b07a4bd781.1456744313.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU_DMA does indeed depend on scatterlists having a DMA length, but
the NEED_SG_DMA_LENGTH symbol should be selected, not depended upon.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b325954..83f1a65 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -70,9 +70,9 @@ config OF_IOMMU
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
 	bool
-	depends on NEED_SG_DMA_LENGTH
 	select IOMMU_API
 	select IOMMU_IOVA
+	select NEED_SG_DMA_LENGTH
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
-- 
2.7.2.333.g70bd996.dirty
