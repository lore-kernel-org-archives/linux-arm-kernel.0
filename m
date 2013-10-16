From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:28 +0530
Subject: [PATCH 10/28] dmaengine: imx-dma: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-11-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 55852c0..2af4028 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -771,7 +771,7 @@ static int imxdma_alloc_chan_resources(struct dma_chan *chan)
 		desc->desc.tx_submit = imxdma_tx_submit;
 		/* txd.flags will be overwritten in prep funcs */
 		desc->desc.flags = DMA_CTRL_ACK;
-		desc->status = DMA_SUCCESS;
+		desc->status = DMA_COMPLETE;
 
 		list_add_tail(&desc->node, &imxdmac->ld_free);
 		imxdmac->descs_allocated++;
-- 
1.7.0.4
