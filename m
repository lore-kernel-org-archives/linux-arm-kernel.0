From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 25 Jan 2010 18:23:04 +0100
Subject: [PATCH] mx2/mx3: debug-macro.S needs deprecated symbols
Message-ID: <1264440184-1740-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/kernel/debug.S:147: Error: constant expression expected -- `ldrne r3,=(((UART1_BASE_ADDR)-AIPI_BASE_ADDR)+AIPI_BASE_ADDR_VIRT)'
	arch/arm/kernel/debug.S:163: Error: constant expression expected -- `ldrne r3,=(((UART1_BASE_ADDR)-AIPI_BASE_ADDR)+AIPI_BASE_ADDR_VIRT)'

when compiling for mx2 with CONFIG_DEBUG_LL=y.  A similar error exists
on mx3 and is fixed by this commit, too.

These were introduced by aae7019382896cf1075a93acc564e42601bc44a2.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

the offending commit is currently in mxc-master but not yet in rmk's
tree.

Best regards
Uwe

 arch/arm/plat-mxc/include/mach/debug-macro.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 15b2b14..21e0f07 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  *
  */
+#define IMX_NEEDS_DEPRECATED_SYMBOLS
 
 #ifdef CONFIG_ARCH_MX1
 #include <mach/mx1.h>
-- 
1.6.6
