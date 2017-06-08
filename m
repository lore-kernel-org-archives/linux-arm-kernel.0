From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:25:58 +0200
Subject: [PATCH 33/44] openrisc: remove arch-specific dma_supported
 implementation
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170608132609.32662-34-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implementation is simply bogus - hexagon only has a simple
direct mapped DMA implementation and thus doesn't care about the
address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/dma-mapping.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
index a4ea139c2ef9..f41bd3cb76d9 100644
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ b/arch/openrisc/include/asm/dma-mapping.h
@@ -33,11 +33,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &or1k_dma_map_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-static inline int dma_supported(struct device *dev, u64 dma_mask)
-{
-	/* Support 32 bit DMA mask exclusively */
-	return dma_mask == DMA_BIT_MASK(32);
-}
-
 #endif	/* __ASM_OPENRISC_DMA_MAPPING_H */
-- 
2.11.0
