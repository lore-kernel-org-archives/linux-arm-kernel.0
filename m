From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 14:21:49 +0200
Subject: [PATCH 2/3] usb: chipidea: udc: fix error path in udc_start()
In-Reply-To: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
References: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1340799710-32696-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the error path of udc_start(). Now NULL is used to
unset the peripheral with otg_set_peripheral().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 6d166a7..eeaeb26 100644
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
