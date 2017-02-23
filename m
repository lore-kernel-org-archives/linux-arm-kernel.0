From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 23 Feb 2017 02:35:12 +0100
Subject: [PATCH 1/2] [TRIVIAL] usb: gadget: Remove duplicated function
 declaration in pxa27x_udc
In-Reply-To: <cover.1487812323.git.petr.cvek@tul.cz>
References: <cover.1487812323.git.petr.cvek@tul.cz>
Message-ID: <4234ff1b-66f3-0be0-ea62-75d622abb044@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated function declaration for udc_enable() and udc_disable().

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 7fa60f5b7ae4..6fa675bf2c6f 100644
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
