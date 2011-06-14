From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 14 Jun 2011 11:58:23 +0100
Subject: [RFC PATCH v2 3/5] ARM: cache-v7: Use new generic struct definition
	macros
In-Reply-To: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308049105-16080-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v7.S |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d32f02b..be4e94b 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -323,18 +323,4 @@ ENTRY(v7_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(v7_dma_unmap_area)
 
-	__INITDATA
-
-	.type	v7_cache_fns, #object
-ENTRY(v7_cache_fns)
-	.long	v7_flush_icache_all
-	.long	v7_flush_kern_cache_all
-	.long	v7_flush_user_cache_all
-	.long	v7_flush_user_cache_range
-	.long	v7_coherent_kern_range
-	.long	v7_coherent_user_range
-	.long	v7_flush_kern_dcache_area
-	.long	v7_dma_map_area
-	.long	v7_dma_unmap_area
-	.long	v7_dma_flush_range
-	.size	v7_cache_fns, . - v7_cache_fns
+	define_cache_functions v7
-- 
1.7.4.1
