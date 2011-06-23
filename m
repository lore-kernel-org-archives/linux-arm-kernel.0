From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:15 +0100
Subject: [PATCH v3 07/40] Subject: ARM: mm: cache-v4wt: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-8-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v4wt.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index a7b276d..16c5603 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -197,16 +197,5 @@ ENDPROC(v4wt_dma_map_area)
 
 	__INITDATA
 
-	.type	v4wt_cache_fns, #object
-ENTRY(v4wt_cache_fns)
-	.long	v4wt_flush_icache_all
-	.long	v4wt_flush_kern_cache_all
-	.long	v4wt_flush_user_cache_all
-	.long	v4wt_flush_user_cache_range
-	.long	v4wt_coherent_kern_range
-	.long	v4wt_coherent_user_range
-	.long	v4wt_flush_kern_dcache_area
-	.long	v4wt_dma_map_area
-	.long	v4wt_dma_unmap_area
-	.long	v4wt_dma_flush_range
-	.size	v4wt_cache_fns, . - v4wt_cache_fns
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions v4wt, default=v4wt
-- 
1.7.4.1
