From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:13 +0100
Subject: [PATCH v3 05/40] Subject: ARM: mm: cache-v4: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-6-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v4.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index a8fefb5..8aa5a7f 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -141,16 +141,5 @@ ENDPROC(v4_dma_map_area)
 
 	__INITDATA
 
-	.type	v4_cache_fns, #object
-ENTRY(v4_cache_fns)
-	.long	v4_flush_icache_all
-	.long	v4_flush_kern_cache_all
-	.long	v4_flush_user_cache_all
-	.long	v4_flush_user_cache_range
-	.long	v4_coherent_kern_range
-	.long	v4_coherent_user_range
-	.long	v4_flush_kern_dcache_area
-	.long	v4_dma_map_area
-	.long	v4_dma_unmap_area
-	.long	v4_dma_flush_range
-	.size	v4_cache_fns, . - v4_cache_fns
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions v4, default=v4
-- 
1.7.4.1
