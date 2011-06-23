From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:14 +0100
Subject: [PATCH v3 06/40] Subject: ARM: mm: cache-v4wb: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-7-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/cache-v4wb.S |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index f40c696..99acac9 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -253,16 +253,5 @@ ENDPROC(v4wb_dma_unmap_area)
 
 	__INITDATA
 
-	.type	v4wb_cache_fns, #object
-ENTRY(v4wb_cache_fns)
-	.long	v4wb_flush_icache_all
-	.long	v4wb_flush_kern_cache_all
-	.long	v4wb_flush_user_cache_all
-	.long	v4wb_flush_user_cache_range
-	.long	v4wb_coherent_kern_range
-	.long	v4wb_coherent_user_range
-	.long	v4wb_flush_kern_dcache_area
-	.long	v4wb_dma_map_area
-	.long	v4wb_dma_unmap_area
-	.long	v4wb_dma_flush_range
-	.size	v4wb_cache_fns, . - v4wb_cache_fns
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions v4wb, default=v4wb
-- 
1.7.4.1
