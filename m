From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Mar 2017 12:07:58 +0100
Subject: [PATCH] spi: loopback-test: fix compile error on x86
Message-ID: <1489748878-15020-1-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix compile error caused by missing vmalloc() definition
on x86 (and maybe other platforms) by including vmalloc.h.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-loopback-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 3596051..4e7843e 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/printk.h>
+#include <linux/vmalloc.h>
 #include <linux/spi/spi.h>
 
 #include "spi-test.h"
-- 
2.7.4
