From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 May 2012 10:23:07 +0200
Subject: [PATCH] usb: gadget: at91_udc: fix endpoint descriptor dereference
Message-ID: <1337156587-7379-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch 5a6506f (Update at91_udc to use usb_endpoint_descriptor inside the
struct usb_ep) removes the desc field of struct at91_ep. This convertion had
not been completed which leads to a compilation error.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/at91_udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 43943aa..1a4430f 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -475,7 +475,7 @@ static int at91_ep_enable(struct usb_ep *_ep,
 	unsigned long	flags;
 
 	if (!_ep || !ep
-			|| !desc || ep->desc
+			|| !desc || ep->ep.desc
 			|| _ep->name == ep0name
 			|| desc->bDescriptorType != USB_DT_ENDPOINT
 			|| (maxpacket = usb_endpoint_maxp(desc)) == 0
-- 
1.7.10
