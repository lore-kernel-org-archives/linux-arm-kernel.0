From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 12 Apr 2012 10:56:39 -0700
Subject: [PATCH] dma-mapping.c: local variables should not be exposed globaly
Message-ID: <201204121056.41398.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable 'consistent_base' is only referenced in this file and
should be marked static to prevent it from being exposed globably.

This quiets the sparse warning:

warning: symbol 'consistent_base' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db23ae4..3d368d3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -130,7 +130,7 @@ static pte_t **consistent_pte;
 
 #define DEFAULT_CONSISTENT_DMA_SIZE SZ_2M
 
-unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
+static unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
 
 void __init init_consistent_dma_size(unsigned long size)
 {
