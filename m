From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 14 Dec 2015 13:22:16 +0200
Subject: [PATCH V02 1/5] dmaengine: core: Skip mask matching when it is not
 provided to private_candidate
In-Reply-To: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1450092140-31602-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If mask is NULL skip the mask matching against the DMA device capabilities.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index daf54a39bcc7..6311e1fc80be 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -515,7 +515,7 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 {
 	struct dma_chan *chan;
 
-	if (!__dma_device_satisfies_mask(dev, mask)) {
+	if (mask && !__dma_device_satisfies_mask(dev, mask)) {
 		pr_debug("%s: wrong capabilities\n", __func__);
 		return NULL;
 	}
-- 
2.6.4
