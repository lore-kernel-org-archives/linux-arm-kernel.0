From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:16 +0100
Subject: [PATCH 03/10] clk/realview: stop using machine headers
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to move realview into multiplatform, we have to prevent device
drivers from accessing the machine header files.

In case of the clk driver, this is very simple, we just copy the
small set of register definitions into the driver that needs them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/versatile/clk-realview.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index 86f70997d59d..bd4dd2463e23 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -11,11 +11,15 @@
 #include <linux/io.h>
 #include <linux/clk-provider.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
 #include "clk-icst.h"
 
+#define REALVIEW_SYS_OSC0_OFFSET             0x0C
+#define REALVIEW_SYS_OSC1_OFFSET             0x10
+#define REALVIEW_SYS_OSC2_OFFSET             0x14
+#define REALVIEW_SYS_OSC3_OFFSET             0x18
+#define REALVIEW_SYS_OSC4_OFFSET             0x1C	/* OSC1 for RealView/AB */
+#define REALVIEW_SYS_LOCK_OFFSET             0x20
+
 /*
  * Implementation of the ARM RealView clock trees.
  */
-- 
2.1.0.rc2
