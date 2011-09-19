From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 19 Sep 2011 16:03:20 +0200
Subject: [PATCH 09/11] at92/ohci: use gpio_is_valid to check the gpio
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1316441002-27381-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-usb at vger.kernel.org
---
Hi,

	I'd like to apply this patch via AT91 with the whole gpio patch series

Best Regards,
J.
 drivers/usb/host/ohci-at91.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index e08cb10..70701f4 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -276,7 +276,7 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		 * active-low power switches.
 		 */
 		for (i = 0; i < ARRAY_SIZE(pdata->vbus_pin); i++) {
-			if (pdata->vbus_pin[i] <= 0)
+			if (!gpio_is_valid(pdata->vbus_pin[i]))
 				continue;
 			gpio_request(pdata->vbus_pin[i], "ohci_vbus");
 			gpio_direction_output(pdata->vbus_pin[i], 0);
@@ -294,7 +294,7 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 
 	if (pdata) {
 		for (i = 0; i < ARRAY_SIZE(pdata->vbus_pin); i++) {
-			if (pdata->vbus_pin[i] <= 0)
+			if (!gpio_is_valid(pdata->vbus_pin[i]))
 				continue;
 			gpio_direction_output(pdata->vbus_pin[i], 1);
 			gpio_free(pdata->vbus_pin[i]);
-- 
1.7.5.4
