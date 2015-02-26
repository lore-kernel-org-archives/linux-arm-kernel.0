From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Feb 2015 17:08:03 +0100
Subject: [PATCH 03/10] clk/realview: stop using machine headers
In-Reply-To: <1424966890-260805-1-git-send-email-arnd@arndb.de>
References: <1424966890-260805-1-git-send-email-arnd@arndb.de>
Message-ID: <1424966890-260805-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to move realview into multiplatform, we have to prevent device
drivers from accessing the machine header files.

In case of the clk driver, this is very simple, we just copy the
small set of register definitions into the driver that needs them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/versatile/clk-realview.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index c8b523117fb7..276411f3c437 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -12,11 +12,15 @@
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
