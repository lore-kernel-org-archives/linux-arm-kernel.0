From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:36 +0530
Subject: [PATCH 18/28] dmaengine: mxs-dma: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-19-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/mxs-dma.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index ccd13df..7ab7cec 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -224,7 +224,7 @@ static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
 
 static void mxs_dma_disable_chan(struct mxs_dma_chan *mxs_chan)
 {
-	mxs_chan->status = DMA_SUCCESS;
+	mxs_chan->status = DMA_COMPLETE;
 }
 
 static void mxs_dma_pause_chan(struct mxs_dma_chan *mxs_chan)
@@ -312,12 +312,12 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 			if (mxs_chan->flags & MXS_DMA_SG_LOOP)
 				mxs_chan->status = DMA_IN_PROGRESS;
 			else
-				mxs_chan->status = DMA_SUCCESS;
+				mxs_chan->status = DMA_COMPLETE;
 		}
 
 		stat1 &= ~(1 << channel);
 
-		if (mxs_chan->status == DMA_SUCCESS)
+		if (mxs_chan->status == DMA_COMPLETE)
 			dma_cookie_complete(&mxs_chan->desc);
 
 		/* schedule tasklet on this channel */
-- 
1.7.0.4
