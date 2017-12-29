From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:14 +0100
Subject: [PATCH 10/67] m32r: remove the unused dma_capable helper
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-11-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m32r/include/asm/dma-mapping.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/m32r/include/asm/dma-mapping.h b/arch/m32r/include/asm/dma-mapping.h
index 336ffe60814b..8967fb659691 100644
--- a/arch/m32r/include/asm/dma-mapping.h
+++ b/arch/m32r/include/asm/dma-mapping.h
@@ -14,11 +14,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 #endif /* _ASM_M32R_DMA_MAPPING_H */
-- 
2.14.2
