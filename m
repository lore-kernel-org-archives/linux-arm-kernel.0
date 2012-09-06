From: balbi@ti.com (Felipe Balbi)
Date: Thu,  6 Sep 2012 15:45:38 +0300
Subject: [PATCH v4 19/21] serial: omap: remove unnecessary header and add a
 missing one
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Message-ID: <1346935540-1792-20-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this driver doesn't use any from <plat/dmtimer.h>, so
we can remove it without any problems.

This will, however cause a problem because omap-serial.c
was relying on indirect inclusion of <linux/platform_device.h>,
let's fix the issue by including <linux/platform_device.h>
on omap-serial.c as it should be.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1ba1f43..881b652 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/serial_core.h>
@@ -40,7 +41,6 @@
 #include <linux/of.h>
 #include <linux/gpio.h>
 
-#include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
 
 #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
-- 
1.7.12.rc3
