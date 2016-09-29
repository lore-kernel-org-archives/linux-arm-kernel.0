From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu, 29 Sep 2016 21:09:21 +0800
Subject: [PATCH] dmaengine: pxa_dma: remove unused function
Message-ID: <1475154561-12327-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 1 warning when building kernel with W=1:
drivers/dma/pxa_dma.c:1525:5: warning: no previous prototype for 'pxad_toggle_reserved_channel' [-Wmissing-prototypes]

In fact, this function is called by no one, so this patch removes it.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/dma/pxa_dma.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 3f56f9c..7d9b1cc 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1522,15 +1522,6 @@ bool pxad_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(pxad_filter_fn);
 
-int pxad_toggle_reserved_channel(int legacy_channel)
-{
-	if (legacy_unavailable & (BIT(legacy_channel)))
-		return -EBUSY;
-	legacy_reserved ^= BIT(legacy_channel);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pxad_toggle_reserved_channel);
-
 module_platform_driver(pxad_driver);
 
 MODULE_DESCRIPTION("Marvell PXA Peripheral DMA Driver");
-- 
2.7.4
