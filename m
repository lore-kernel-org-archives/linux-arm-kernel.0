From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:44 +0200
Subject: [PATCH 29/44] dma-noop: remove dma_supported and mapping_error methods
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-30-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These just duplicate the default behavior if no method is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-noop.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index de26c8b68f34..643a074f139d 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -54,23 +54,11 @@ static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nent
 	return nents;
 }
 
-static int dma_noop_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static int dma_noop_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 const struct dma_map_ops dma_noop_ops = {
 	.alloc			= dma_noop_alloc,
 	.free			= dma_noop_free,
 	.map_page		= dma_noop_map_page,
 	.map_sg			= dma_noop_map_sg,
-	.mapping_error		= dma_noop_mapping_error,
-	.dma_supported		= dma_noop_supported,
 };
 
 EXPORT_SYMBOL(dma_noop_ops);
-- 
2.11.0
