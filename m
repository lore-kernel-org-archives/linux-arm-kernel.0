From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:09:18 +0200
Subject: [PATCH 09/11] ARM: at92/ohci: use gpio_is_valid to check the gpio
In-Reply-To: <20111016190528.GI1459@game.jcrosoft.org>
References: <20111016190528.GI1459@game.jcrosoft.org>
Message-ID: <1318792160-23279-9-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/host/ohci-at91.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index ba3a46b..4b9ac13 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -459,7 +459,7 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 
 	if (pdata) {
 		for (i = 0; i < ARRAY_SIZE(pdata->vbus_pin); i++) {
-			if (pdata->vbus_pin[i] <= 0)
+			if (!gpio_is_valid(pdata->vbus_pin[i]))
 				continue;
 			gpio_request(pdata->vbus_pin[i], "ohci_vbus");
 			ohci_at91_usb_set_power(pdata, i, 1);
@@ -493,7 +493,7 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 
 	if (pdata) {
 		for (i = 0; i < ARRAY_SIZE(pdata->vbus_pin); i++) {
-			if (pdata->vbus_pin[i] <= 0)
+			if (!gpio_is_valid(pdata->vbus_pin[i]))
 				continue;
 			ohci_at91_usb_set_power(pdata, i, 0);
 			gpio_free(pdata->vbus_pin[i]);
-- 
1.7.7
