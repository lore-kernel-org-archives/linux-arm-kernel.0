From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:16 +0100
Subject: [PATCH v4 09/40] ARM: mm: cache-v7: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-10-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v7.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d32f02b..3b24bfa 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -325,16 +325,5 @@ ENDPROC(v7_dma_unmap_area)
 
 	__INITDATA
 
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
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions v7
-- 
1.7.4.1
