From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:33 +0800
Subject: [PATCH 05/14] usb: lpc32xx_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-6-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/lpc32xx_udc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
index aa04089..13270a9 100644
--- a/drivers/usb/gadget/lpc32xx_udc.c
+++ b/drivers/usb/gadget/lpc32xx_udc.c
@@ -2550,6 +2550,7 @@ static int lpc32xx_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	spin_lock_irqsave(&udc->lock, flags);
 
+	gadget->vbus_active = is_active;
 	/* Doesn't need lock */
 	if (udc->driver) {
 		udc_clk_set(udc, 1);
-- 
1.7.0.4
