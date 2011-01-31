From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 12:59:30 +0100
Subject: [PATCH 3/5] dmaengine i.MX SDMA: do not initialize chan_id field
In-Reply-To: <1296475172-23900-1-git-send-email-s.hauer@pengutronix.de>
References: <1296475172-23900-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296475172-23900-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is bogus as the dmaengine core will overwrite this field.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8707723..3e848ee 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1307,7 +1307,6 @@ static int __init sdma_probe(struct platform_device *pdev)
 		dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
 
 		sdmac->chan.device = &sdma->dma_device;
-		sdmac->chan.chan_id = i;
 		sdmac->channel = i;
 
 		/* Add the channel to the DMAC list */
-- 
1.7.2.3
