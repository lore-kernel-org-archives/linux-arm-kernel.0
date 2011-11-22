From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 22 Nov 2011 10:07:27 +0100
Subject: [PATCH 2/2] ARM: imx: export imx_ioremap to allow modules to use
 ioremap
In-Reply-To: <20111122090622.GC19986@pengutronix.de>
References: <20111122090622.GC19986@pengutronix.de>
Message-ID: <1321952847-3178-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/system.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 80de9e2..85d5da8 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/err.h>
@@ -30,6 +31,7 @@
 
 void (*imx_idle)(void) = NULL;
 void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
+EXPORT_SYMBOL(imx_ioremap);
 
 static void __iomem *wdog_base;
 
-- 
1.7.7.2
