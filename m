From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 23:16:44 +0100
Subject: [PATCH 4/9] usb: gadget: fix omap_udc build errors
In-Reply-To: <1362521809-22989-1-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
Message-ID: <1362521809-22989-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1bf0cf6040 "usb: gadget: omap_udc: convert to udc_start/udc_stop"
made some trivial changes but was missing a ';' character.

8c4cc00552 "ARM: OMAP1: DMA: Moving OMAP1 DMA channel definitions
to mach-omap1" added a definition for OMAP_DMA_USB_W2FC_TX0 to
the driver while making the header file it was defined in
unavailable for drivers, but this driver actually needs
OMAP_DMA_USB_W2FC_RX0 as well.

Both changes appear trivial, so let's add the missing semicolon
and the macro definition.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/omap_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 06be85c..f844565 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -62,6 +62,7 @@
 #define	DRIVER_VERSION	"4 October 2004"
 
 #define OMAP_DMA_USB_W2FC_TX0		29
+#define OMAP_DMA_USB_W2FC_RX0		26
 
 /*
  * The OMAP UDC needs _very_ early endpoint setup:  before enabling the
@@ -1310,7 +1311,7 @@ static int omap_pullup(struct usb_gadget *gadget, int is_on)
 }
 
 static int omap_udc_start(struct usb_gadget *g,
-		struct usb_gadget_driver *driver)
+		struct usb_gadget_driver *driver);
 static int omap_udc_stop(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
 
-- 
1.8.1.2
