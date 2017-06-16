From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:26 +0200
Subject: [PATCH 11/44] m32r: remove DMA_ERROR_CODE
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-12-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma-noop is the only dma_mapping_ops instance for m32r and does not return
errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m32r/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m32r/include/asm/dma-mapping.h b/arch/m32r/include/asm/dma-mapping.h
index c01d9f52d228..aff3ae8b62f7 100644
--- a/arch/m32r/include/asm/dma-mapping.h
+++ b/arch/m32r/include/asm/dma-mapping.h
@@ -8,8 +8,6 @@
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
-#define DMA_ERROR_CODE (~(dma_addr_t)0x0)
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &dma_noop_ops;
-- 
2.11.0
