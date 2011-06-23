From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:16 +0100
Subject: [PATCH v3 08/40] Subject: ARM: mm: cache-v6: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-9-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v6.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 73b4a8b..e14084a 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -330,16 +330,5 @@ ENDPROC(v6_dma_unmap_area)
 
 	__INITDATA
 
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
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions v6, default=v6
-- 
1.7.4.1
