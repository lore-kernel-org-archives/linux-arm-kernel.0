From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 01 Jul 2011 16:37:52 +0800
Subject: [PATCH] ARM: DMA: Add missing semicolon for the define of
	dma_alloc_area
Message-ID: <1309509472.30642.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got below build error by: make at91x40_defconfig;make
Fix it by adding a missing semicolon for the define of dma_alloc_area.

  CC      arch/arm/mm/dma-mapping.o
arch/arm/mm/dma-mapping.c:309: warning: 'struct dma_coherent_area' declared inside parameter list
arch/arm/mm/dma-mapping.c:309: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mm/dma-mapping.c: In function '__dma_alloc':
arch/arm/mm/dma-mapping.c:324: error: expected ';' before '}' token
arch/arm/mm/dma-mapping.c: At top level:
arch/arm/mm/dma-mapping.c:334: warning: 'struct dma_coherent_area' declared inside parameter list
arch/arm/mm/dma-mapping.c:374: warning: 'struct dma_coherent_area' declared inside parameter list
make[1]: *** [arch/arm/mm/dma-mapping.o] Error 1
make: *** [arch/arm/mm] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 3ec2129..090690d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -291,7 +291,7 @@ static void dma_free_area(void *cpu_addr, size_t size, struct dma_coherent_area
 
 #else	/* !CONFIG_MMU */
 
-#define dma_alloc_area(size, pfn, gfp, area)	({ *(pfn) = 0; NULL })
+#define dma_alloc_area(size, pfn, gfp, area)	({ *(pfn) = 0; NULL; })
 #define dma_free_area(addr, size, area)		do { } while (0)
 
 #define nommu()	(1)
-- 
1.7.4.1
