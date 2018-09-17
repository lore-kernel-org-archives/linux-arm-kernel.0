From: hch@lst.de (Christoph Hellwig)
Date: Mon, 17 Sep 2018 17:38:18 +0200
Subject: [PATCH 1/9] swiotlb: remove a pointless comment
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
Message-ID: <20180917153826.28052-2-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This comments describes an aspect of the map_sg interface that isn't
even exploited by swiotlb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6dbf0b60..9062b14bc7f4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -925,12 +925,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * appropriate dma address and length.  They are obtained via
  * sg_dma_{address,length}(SG).
  *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
  * Device ownership issues as mentioned above for swiotlb_map_page are the
  * same here.
  */
-- 
2.18.0
