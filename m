From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Thu,  8 Oct 2015 14:36:57 +0530
Subject: [PATCH v2] dmaengine: xgene-dma: Disable memcpy operation due to
 performance drop
Message-ID: <1444295217-3099-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA engine supports memory copy, RAID5 XOR, RAID6 PQ, and other
computations. But the bandwidth of the entire DMA engine is shared
among all channels. This patch re-configures operations availability
such that one can achieve maximum performance for XOR and PQ
computation by removing the memory offload operations.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 drivers/dma/xgene-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 8d57b1b..cd38022 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1707,7 +1707,6 @@ static void xgene_dma_set_caps(struct xgene_dma_chan *chan,
 	dma_cap_zero(dma_dev->cap_mask);

 	/* Set DMA device capability */
-	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
 	dma_cap_set(DMA_SG, dma_dev->cap_mask);

 	/* Basically here, the X-Gene SoC DMA engine channel 0 supports XOR
--
1.8.2.1
