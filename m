From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 13:00:47 +0100
Subject: [PATCH 3/4] dmaengine i.MX DMA: do not initialize chan_id field
In-Reply-To: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
References: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296475248-29095-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-dma.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index a1eac99..8262708 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -366,7 +366,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		dma_cap_set(DMA_CYCLIC, imxdma->dma_device.cap_mask);
 
 		imxdmac->chan.device = &imxdma->dma_device;
-		imxdmac->chan.chan_id = i;
 		imxdmac->channel = i;
 
 		/* Add the channel to the DMAC list */
-- 
1.7.2.3
