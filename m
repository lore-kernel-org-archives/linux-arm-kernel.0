From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 21 Nov 2012 15:06:28 +0100
Subject: [PATCH v3 2/7] usb: chipidea: usbmisc: unset global varibale usbmisc
 on driver remove
In-Reply-To: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1353506793-8354-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

The probe function checks usbmisc to be NULL in the beginning. Without
this patch the can only be loaded once.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes since v1:
* split previous patch into two seperate.

 drivers/usb/chipidea/usbmisc_imx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 5da379a..552c63f 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -131,6 +131,7 @@ static int __devexit usbmisc_imx_remove(struct platform_device *pdev)
 {
 	usbmisc_unset_ops(&imx6q_usbmisc_ops);
 	clk_disable_unprepare(usbmisc->clk);
+	usbmisc = NULL;
 	return 0;
 }
 
-- 
1.7.10.4
