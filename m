From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:50 -0400
Subject: [PATCH 06/37] ARM: plat-omap: remove
	CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE related code
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is simply no such Kconfig entry in the tree. This is dead code.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/plat-omap/include/plat/memory.h |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index e6720aa..7f9df6f 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -85,18 +85,5 @@
 
 #endif	/* CONFIG_ARCH_OMAP15XX */
 
-/* Override the ARM default */
-#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-
-#if (CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE == 0)
-#undef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-#define CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE 2
-#endif
-
-#define CONSISTENT_DMA_SIZE \
-	(((CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE + 1) & ~1) * 1024 * 1024)
-
-#endif
-
 #endif
 
-- 
1.7.4
