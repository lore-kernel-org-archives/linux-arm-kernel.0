From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:12 +0100
Subject: [PATCH v3 04/40] Subject: ARM: mm: cache-v3: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-5-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v3.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-v3.S b/arch/arm/mm/cache-v3.S
index 2e2bc40..1e1748f 100644
--- a/arch/arm/mm/cache-v3.S
+++ b/arch/arm/mm/cache-v3.S
@@ -129,16 +129,5 @@ ENDPROC(v3_dma_map_area)
 
 	__INITDATA
 
-	.type	v3_cache_fns, #object
-ENTRY(v3_cache_fns)
-	.long	v3_flush_icache_all
-	.long	v3_flush_kern_cache_all
-	.long	v3_flush_user_cache_all
-	.long	v3_flush_user_cache_range
-	.long	v3_coherent_kern_range
-	.long	v3_coherent_user_range
-	.long	v3_flush_kern_dcache_area
-	.long	v3_dma_map_area
-	.long	v3_dma_unmap_area
-	.long	v3_dma_flush_range
-	.size	v3_cache_fns, . - v3_cache_fns
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions v3, default=v3
-- 
1.7.4.1
