From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 13:09:07 +0200
Subject: [PATCH 23/37] usb: gadget: net2272: add ep capabilities support
In-Reply-To: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436353761-7107-24-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/net2272.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 195baf3..34ec1ec 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -1404,6 +1404,17 @@ net2272_usb_reinit(struct net2272 *dev)
 		else
 			ep->fifo_size = 64;
 		net2272_ep_reset(ep);
+
+		if (i == 0) {
+			ep->ep.caps.type_control = true;
+		} else {
+			ep->ep.caps.type_iso = true;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
+		}
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
 	}
 	usb_ep_set_maxpacket_limit(&dev->ep[0].ep, 64);
 
-- 
1.9.1
