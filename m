From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:25:40 +0200
Subject: [PATCH 15/44] xtensa: remove DMA_ERROR_CODE
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170608132609.32662-16-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xtensa already implements the mapping_error method for its only
dma_map_ops instance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index c6140fa8c0be..269738dc9d1d 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -16,8 +16,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 
-#define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
-
 extern const struct dma_map_ops xtensa_dma_map_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-- 
2.11.0
