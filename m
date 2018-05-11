From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 11 May 2018 12:19:55 +0200
Subject: [PATCH v2 2/3] usb: gadget: udc: atmel: Remove obsolete include
In-Reply-To: <20180511101956.11782-1-romain.izard.pro@gmail.com>
References: <20180511101956.11782-1-romain.izard.pro@gmail.com>
Message-ID: <20180511101956.11782-3-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The include defines the private platform_data structure used with AVR
platforms. It has no user since 7c55984e191f. Remove it.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c |  1 -
 include/linux/usb/atmel_usba_udc.h      | 24 ------------------------
 2 files changed, 25 deletions(-)
 delete mode 100644 include/linux/usb/atmel_usba_udc.h

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 0fe3d0feb8f7..b9623e228609 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -20,7 +20,6 @@
 #include <linux/ctype.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb/atmel_usba_udc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/irq.h>
diff --git a/include/linux/usb/atmel_usba_udc.h b/include/linux/usb/atmel_usba_udc.h
deleted file mode 100644
index 9bb00df3b53f..000000000000
--- a/include/linux/usb/atmel_usba_udc.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Platform data definitions for Atmel USBA gadget driver.
- */
-#ifndef __LINUX_USB_USBA_H
-#define __LINUX_USB_USBA_H
-
-struct usba_ep_data {
-	char	*name;
-	int	index;
-	int	fifo_size;
-	int	nr_banks;
-	int	can_dma;
-	int	can_isoc;
-};
-
-struct usba_platform_data {
-	int			vbus_pin;
-	int			vbus_pin_inverted;
-	int			num_ep;
-	struct usba_ep_data	ep[0];
-};
-
-#endif /* __LINUX_USB_USBA_H */
-- 
2.14.1
