From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 13:09:01 +0200
Subject: [PATCH 17/37] usb: gadget: goku_udc: add ep capabilities support
In-Reply-To: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436353761-7107-18-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/goku_udc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 9e8d842..46b8d14 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1257,6 +1257,14 @@ static void udc_reinit (struct goku_udc *dev)
 		INIT_LIST_HEAD (&ep->queue);
 
 		ep_reset(NULL, ep);
+
+		if (i == 0)
+			ep->ep.caps.type_control = true;
+		else
+			ep->ep.caps.type_bulk = true;
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
 	}
 
 	dev->ep[0].reg_mode = NULL;
-- 
1.9.1
