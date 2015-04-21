From: loic.tourlonias@gmail.com (=?UTF-8?Q?lo=C3=AFc_tourlonias?=)
Date: Tue, 21 Apr 2015 14:52:35 +0200
Subject: Fwd: [PATCH] usb-otg: atmel-usba-udc: initialize usb_prev to the
 actual value
In-Reply-To: <CA+XxOSExCVBd0TFuY+wmjL-pxhp148H1FpnQLBtV0q2R5OwHzg@mail.gmail.com>
References: <CA+XxOSExCVBd0TFuY+wmjL-pxhp148H1FpnQLBtV0q2R5OwHzg@mail.gmail.com>
Message-ID: <CA+XxOSFO1zYKJLaAQ6qixReUaViizOPve445B1rrKE+Om2xRPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During start of the usb gadget device, usb_prev must be initialize to
the actual value of vbus_pin to avoid missing the first usb host
detection.

Signed-off-by: ltourlonias <loic.tourlonias@gmail.com>
---
 drivers/usb/gadget/atmel_usba_udc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c
b/drivers/usb/gadget/atmel_usba_udc.c
index 1d97222..258edf9 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1796,6 +1796,7 @@ static int atmel_usba_start(struct usb_gadget *gadget,
  toggle_bias(1);
  usba_writel(udc, CTRL, USBA_ENABLE_MASK);
  usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+ udc->vbus_prev=1;
  }
  spin_unlock_irqrestore(&udc->lock, flags);

-- 
1.7.10.4
