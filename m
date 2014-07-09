From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  9 Jul 2014 11:24:44 +0200
Subject: [PATCH] usb: gadget: pxa25x_udc: use correct header for gpio devm_
 functions
Message-ID: <1404897884-1112359-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit c63d2225e7be ("usb: gadget: pxa25x_udc: use devm_ functions")
introduced the use of devm_gpio_request in this driver, but did not
correctly include the header file declaring this function, which
causes a build failure.

This changes pxa25x_udc to include linux/gpio.h instead of asm/gpio.h
to fix this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Himangi Saraogi <himangi774@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index f1a5cdc..251e4d5 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -16,6 +16,7 @@
 /* #define VERBOSE_DEBUG */
 
 #include <linux/device.h>
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
@@ -40,7 +41,6 @@
 
 #include <asm/byteorder.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/unaligned.h>
 
-- 
1.8.3.2
