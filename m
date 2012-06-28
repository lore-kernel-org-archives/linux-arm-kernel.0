From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Jun 2012 15:53:47 +0200
Subject: [PATCH v2 2/4] usb: chipidea: udc: fix error path in udc_start()
In-Reply-To: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1340891629-13145-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the error path of udc_start(). Now NULL is used to
unset the peripheral with otg_set_peripheral().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 5760a10..adcc77d 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1739,7 +1739,7 @@ static int udc_start(struct ci13xxx *ci)
 
 remove_trans:
 	if (ci->transceiver) {
-		otg_set_peripheral(ci->transceiver->otg, &ci->gadget);
+		otg_set_peripheral(ci->transceiver->otg, NULL);
 		if (ci->global_phy)
 			usb_put_transceiver(ci->transceiver);
 	}
-- 
1.7.10
