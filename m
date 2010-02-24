From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:31 +0100
Subject: [PATCH 36/39] arm/mx25: don't include iomux.h which is for iomux-v1
	machines
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-36-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/mach-mx25pdk.c      |    2 +-
 arch/arm/plat-mxc/include/mach/iomux.h |    4 ----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx25/mach-mx25pdk.c b/arch/arm/mach-mx25/mach-mx25pdk.c
index 10be38e..cb85e2e 100644
--- a/arch/arm/mach-mx25/mach-mx25pdk.c
+++ b/arch/arm/mach-mx25/mach-mx25pdk.c
@@ -36,7 +36,7 @@
 #include <mach/mx25.h>
 #include <mach/mxc_nand.h>
 #include "devices.h"
-#include <mach/iomux.h>
+#include <mach/iomux-mx25.h>
 
 static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/plat-mxc/include/mach/iomux.h b/arch/arm/plat-mxc/include/mach/iomux.h
index e15d28a..8b2467f 100644
--- a/arch/arm/plat-mxc/include/mach/iomux.h
+++ b/arch/arm/plat-mxc/include/mach/iomux.h
@@ -109,10 +109,6 @@
 #include <mach/iomux-mx27.h>
 #endif
 #endif
-#ifdef CONFIG_ARCH_MX25
-#include <mach/iomux-mx25.h>
-#endif
-
 
 /* decode irq number to use with IMR(x), ISR(x) and friends */
 #define IRQ_TO_REG(irq) ((irq - MXC_INTERNAL_IRQS) >> 5)
-- 
1.6.6.2
