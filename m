From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:11 +0100
Subject: [PATCH v3 03/40] Subject: ARM: mm: cache-fa: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-fa.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 1fa6f71..77509ef 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -242,16 +242,5 @@ ENDPROC(fa_dma_unmap_area)
 
 	__INITDATA
 
-	.type	fa_cache_fns, #object
-ENTRY(fa_cache_fns)
-	.long	fa_flush_icache_all
-	.long	fa_flush_kern_cache_all
-	.long	fa_flush_user_cache_all
-	.long	fa_flush_user_cache_range
-	.long	fa_coherent_kern_range
-	.long	fa_coherent_user_range
-	.long	fa_flush_kern_dcache_area
-	.long	fa_dma_map_area
-	.long	fa_dma_unmap_area
-	.long	fa_dma_flush_range
-	.size	fa_cache_fns, . - fa_cache_fns
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions fa, default=fa
-- 
1.7.4.1
