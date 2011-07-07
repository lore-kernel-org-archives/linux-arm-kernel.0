From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:12 +0100
Subject: [PATCH v4 05/40] ARM: mm: cache-v4: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-6-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v4.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index a8fefb5..fd9bb7a 100644
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
+	define_cache_functions v4
-- 
1.7.4.1
