From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 9 Apr 2015 12:35:53 +0300
Subject: [PATCH v5 7/8] dmaengine: omap-dma: Reduce the number of virtual
 channels
In-Reply-To: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1428572154-3548-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the mapping between the hardware request lines and channels has been
removed it no longer make sense to have too many channels.
Set the number of channels to match with the number of logical channels
supported by sDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index b19b9ee8f1d1..7f154c138200 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1129,7 +1129,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 			 OMAP_SDMA_REQUESTS);
 	}
 
-	for (i = 0; i < od->dma_requests; i++) {
+	for (i = 0; i < OMAP_SDMA_CHANNELS; i++) {
 		rc = omap_dma_chan_init(od);
 		if (rc) {
 			omap_dma_free(od);
-- 
2.3.5
