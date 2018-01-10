From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 09:00:03 +0100
Subject: [PATCH 09/33] dma-mapping: take dma_pfn_offset into account in
 dma_max_pfn
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Message-ID: <20180110080027.13879-10-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes sure the generic version can be used with architectures /
devices that have a DMA offset in the direct mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 81ed9b2d84dc..d84951865be7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
-	return *dev->dma_mask >> PAGE_SHIFT;
+	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
 }
 #endif
 
-- 
2.14.2
