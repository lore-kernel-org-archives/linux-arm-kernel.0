From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:43 +0530
Subject: [PATCH 25/28] dmaengine: txx9: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-26-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/txx9dmac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 71e8e77..c2829b4 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -962,8 +962,8 @@ txx9dmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	enum dma_status ret;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_SUCCESS)
-		return DMA_SUCCESS;
+	if (ret == DMA_COMPLETE)
+		return DMA_COMPLETE;
 
 	spin_lock_bh(&dc->lock);
 	txx9dmac_scan_descriptors(dc);
-- 
1.7.0.4
