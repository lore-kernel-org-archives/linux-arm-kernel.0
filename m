From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:45 +0200
Subject: [PATCH 30/44] dma-virt: remove dma_supported and mapping_error methods
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-31-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These just duplicate the default behavior if no method is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-virt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/dma-virt.c b/lib/dma-virt.c
index dcd4df1f7174..5c4f11329721 100644
--- a/lib/dma-virt.c
+++ b/lib/dma-virt.c
@@ -51,22 +51,10 @@ static int dma_virt_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static int dma_virt_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return false;
-}
-
-static int dma_virt_supported(struct device *dev, u64 mask)
-{
-	return true;
-}
-
 const struct dma_map_ops dma_virt_ops = {
 	.alloc			= dma_virt_alloc,
 	.free			= dma_virt_free,
 	.map_page		= dma_virt_map_page,
 	.map_sg			= dma_virt_map_sg,
-	.mapping_error		= dma_virt_mapping_error,
-	.dma_supported		= dma_virt_supported,
 };
 EXPORT_SYMBOL(dma_virt_ops);
-- 
2.11.0
