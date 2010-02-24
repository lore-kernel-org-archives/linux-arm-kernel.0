From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:20 +0100
Subject: [PATCH 25/39] arm/imx: choose sane CONSISTENT_DMA_SIZE if video is
	enabled for both mx1 and mx3
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-25-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/memory.h |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 002eb91..d636564 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -34,20 +34,19 @@
 # endif
 #endif
 
-#if defined(CONFIG_MX1_VIDEO)
+#if defined(CONFIG_MX3_VIDEO)
 /*
  * Increase size of DMA-consistent memory region.
- * This is required for i.MX camera driver to capture at least four VGA frames.
+ * This is required for mx3 camera driver to capture at least two QXGA frames.
  */
-#define CONSISTENT_DMA_SIZE SZ_4M
-#endif /* CONFIG_MX1_VIDEO */
+#define CONSISTENT_DMA_SIZE SZ_8M
 
-#if defined(CONFIG_MX3_VIDEO)
+#elif defined(CONFIG_MX1_VIDEO)
 /*
  * Increase size of DMA-consistent memory region.
- * This is required for mx3 camera driver to capture at least two QXGA frames.
+ * This is required for i.MX camera driver to capture at least four VGA frames.
  */
-#define CONSISTENT_DMA_SIZE SZ_8M
-#endif /* CONFIG_MX3_VIDEO */
+#define CONSISTENT_DMA_SIZE SZ_4M
+#endif /* CONFIG_MX1_VIDEO */
 
 #endif /* __ASM_ARCH_MXC_MEMORY_H__ */
-- 
1.6.6.2
