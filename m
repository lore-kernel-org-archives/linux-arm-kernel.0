From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu,  9 Mar 2017 18:02:43 +0100
Subject: [PATCH v1] usb: gadget: udc: atmel: Remove an unused local variable
Message-ID: <20170309170243.27388-1-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The local variable ept_cfg is not used anymore in usba_ep_enable.
Use ep->ept_cfg in the debug function to remove a warning when building
with dynamic debug enabled.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Fixes: 741d2558bf0a ("usb: gadget: udc: atmel: Update endpoint allocation scheme")
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 11bbce28bc23..2035906b8ced 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -610,7 +610,7 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 {
 	struct usba_ep *ep = to_usba_ep(_ep);
 	struct usba_udc *udc = ep->udc;
-	unsigned long flags, ept_cfg, maxpacket;
+	unsigned long flags, maxpacket;
 	unsigned int nr_trans;
 
 	DBG(DBG_GADGET, "%s: ep_enable: desc=%p\n", ep->ep.name, desc);
@@ -630,7 +630,7 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 	ep->is_in = 0;
 
 	DBG(DBG_ERR, "%s: EPT_CFG = 0x%lx (maxpacket = %lu)\n",
-			ep->ep.name, ept_cfg, maxpacket);
+			ep->ep.name, ep->ept_cfg, maxpacket);
 
 	if (usb_endpoint_dir_in(desc)) {
 		ep->is_in = 1;
-- 
2.9.3
