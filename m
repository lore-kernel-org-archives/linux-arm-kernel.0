From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 24 Feb 2017 02:54:12 +0100
Subject: [PATCH v2 1/2] usb: gadget: pxa27x: Remove duplicate function
 prototype
In-Reply-To: <cover.1487901100.git.petr.cvek@tul.cz>
References: <cover.1487901100.git.petr.cvek@tul.cz>
Message-ID: <9f125a32-1d2a-54ea-ccd8-8d8b494c6f3a@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions udc_enable() and udc_disable() have a duplicated prototype.
Remove it.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index e1335ad5bce9..821bd8f4cae6 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1608,9 +1608,6 @@ static int pxa_udc_pullup(struct usb_gadget *_gadget, int is_active)
 	return 0;
 }
 
-static void udc_enable(struct pxa_udc *udc);
-static void udc_disable(struct pxa_udc *udc);
-
 /**
  * pxa_udc_vbus_session - Called by external transceiver to enable/disable udc
  * @_gadget: usb gadget
-- 
2.11.0
