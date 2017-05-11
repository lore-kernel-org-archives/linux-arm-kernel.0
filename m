From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 May 2017 13:35:51 +0200
Subject: [PATCH] iommu/mediatek: include linux/dma-mapping.h
Message-ID: <20170511113619.2596882-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mediatek iommu driver relied on an implicit include of dma-mapping.h,
but for some reason that is no longer there in 4.12-rc1:

drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_domain_finalise':
drivers/iommu/mtk_iommu_v1.c:233:16: error: implicit declaration of function 'dma_zalloc_coherent'; did you mean 'debug_dma_alloc_coherent'? [-Werror=implicit-function-declaration]
drivers/iommu/mtk_iommu_v1.c: In function 'mtk_iommu_domain_free':
drivers/iommu/mtk_iommu_v1.c:265:2: error: implicit declaration of function 'dma_free_coherent'; did you mean 'debug_dma_free_coherent'? [-Werror=implicit-function-declaration]

This adds an explicit #include to make it build again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/mtk_iommu_v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a27ef570c328..bc1efbfb9ddf 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-- 
2.9.0
