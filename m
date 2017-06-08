From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:25:39 +0200
Subject: [PATCH 14/44] sh: remove DMA_ERROR_CODE
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170608132609.32662-15-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sh does not return errors for dma_map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index d99008af5f73..9b06be07db4d 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -9,8 +9,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-#define DMA_ERROR_CODE 0
-
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		    enum dma_data_direction dir);
 
-- 
2.11.0
