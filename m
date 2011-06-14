From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 14 Jun 2011 11:58:25 +0100
Subject: [RFC PATCH v2 5/5] ARM: cache-v6: Use new generic struct definition
	macros
In-Reply-To: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308049105-16080-6-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v6.S |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 73b4a8b..93d3bf8 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -328,18 +328,4 @@ ENTRY(v6_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(v6_dma_unmap_area)
 
-	__INITDATA
-
-	.type	v6_cache_fns, #object
-ENTRY(v6_cache_fns)
-	.long	v6_flush_icache_all
-	.long	v6_flush_kern_cache_all
-	.long	v6_flush_user_cache_all
-	.long	v6_flush_user_cache_range
-	.long	v6_coherent_kern_range
-	.long	v6_coherent_user_range
-	.long	v6_flush_kern_dcache_area
-	.long	v6_dma_map_area
-	.long	v6_dma_unmap_area
-	.long	v6_dma_flush_range
-	.size	v6_cache_fns, . - v6_cache_fns
+	define_cache_functions v6
-- 
1.7.4.1
