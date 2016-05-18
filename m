From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 18 May 2016 13:17:31 +0530
Subject: [PATCH v2 2/4] dmaengine: vdma: Use dma_pool_zalloc
In-Reply-To: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
References: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
Message-ID: <1463557653-1687-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_pool_zalloc combines dma_pool_alloc and memset 0
this patch updates the driver to use dma_pool_zalloc.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> New patch.

 drivers/dma/xilinx/xilinx_vdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 3edd454..0f5b38a 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -498,11 +498,10 @@ xilinx_cdma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 	struct xilinx_cdma_tx_segment *segment;
 	dma_addr_t phys;
 
-	segment = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &phys);
+	segment = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &phys);
 	if (!segment)
 		return NULL;
 
-	memset(segment, 0, sizeof(*segment));
 	segment->phys = phys;
 
 	return segment;
@@ -520,11 +519,10 @@ xilinx_axidma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 	struct xilinx_axidma_tx_segment *segment;
 	dma_addr_t phys;
 
-	segment = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &phys);
+	segment = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &phys);
 	if (!segment)
 		return NULL;
 
-	memset(segment, 0, sizeof(*segment));
 	segment->phys = phys;
 
 	return segment;
-- 
2.1.2
