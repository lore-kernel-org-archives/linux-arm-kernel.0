From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:26:01 +0200
Subject: [PATCH 36/44] dma-mapping: remove HAVE_ARCH_DMA_SUPPORTED
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170608132609.32662-37-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a57875309bfd..3e5908656226 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -549,7 +549,6 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
-#ifndef HAVE_ARCH_DMA_SUPPORTED
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -560,7 +559,6 @@ static inline int dma_supported(struct device *dev, u64 mask)
 		return 1;
 	return ops->dma_supported(dev, mask);
 }
-#endif
 
 #ifndef HAVE_ARCH_DMA_SET_MASK
 static inline int dma_set_mask(struct device *dev, u64 mask)
-- 
2.11.0
