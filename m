From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:25:37 +0200
Subject: [PATCH 12/44] microblaze: remove DMA_ERROR_CODE
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170608132609.32662-13-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

microblaze does not return errors for dma_map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index 3fad5e722a66..e15cd2f76e23 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -28,8 +28,6 @@
 #include <asm/io.h>
 #include <asm/cacheflush.h>
 
-#define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
-
 #define __dma_alloc_coherent(dev, gfp, size, handle)	NULL
 #define __dma_free_coherent(size, addr)		((void)0)
 
-- 
2.11.0
