From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:18 +0100
Subject: [PATCH 32/63] dmaengine: ste_dma40: Remove redundant address fetching
 function
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-33-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addresses are now stored in local data structures and are easy to
obtain, thus a specialist function used to fetch them is now surplus
to requirement.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 3ff6ea4..555d851 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2253,24 +2253,6 @@ err:
 	return NULL;
 }
 
-static dma_addr_t
-d40_get_dev_addr(struct d40_chan *chan, enum dma_transfer_direction direction)
-{
-	struct stedma40_platform_data *plat = chan->base->plat_data;
-	struct stedma40_chan_cfg *cfg = &chan->dma_cfg;
-	dma_addr_t addr = 0;
-
-	if (chan->runtime_addr)
-		return chan->runtime_addr;
-
-	if (direction == DMA_DEV_TO_MEM)
-		addr = plat->dev_rx[cfg->dev_type];
-	else if (direction == DMA_MEM_TO_DEV)
-		addr = plat->dev_tx[cfg->dev_type];
-
-	return addr;
-}
-
 static struct dma_async_tx_descriptor *
 d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
 	    struct scatterlist *sg_dst, unsigned int sg_len,
-- 
1.7.10.4
