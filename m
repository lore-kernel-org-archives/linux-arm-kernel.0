From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:19 +0100
Subject: [PATCH 24/39] arm/imx/irq: order definitions of MXC_GPIO_IRQS
	numerically
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-24-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is important for kernels supporting more than one SoC.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/irqs.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 0cb3476..7ebdd71 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -18,16 +18,17 @@
 
 #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
 
-#if defined CONFIG_ARCH_MX1
-#define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX2
+/* these are ordered by size to support multi-SoC kernels */
+#if defined CONFIG_ARCH_MX2
 #define MXC_GPIO_IRQS		(32 * 6)
-#elif defined CONFIG_ARCH_MX3
-#define MXC_GPIO_IRQS		(32 * 3)
+#elif defined CONFIG_ARCH_MX1
+#define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MX25
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MXC91231
 #define MXC_GPIO_IRQS		(32 * 4)
+#elif defined CONFIG_ARCH_MX3
+#define MXC_GPIO_IRQS		(32 * 3)
 #endif
 
 /*
-- 
1.6.6.2
