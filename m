From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:44:37 +0000
Subject: [PATCH 07/40] ab8500-charger: Trivial coding style changes
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enforce the white space character after 'if'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/ab8500_charger.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index fd3fa2b..dcd3c6f 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -3152,10 +3152,10 @@ static int ab8500_charger_remove(struct platform_device *pdev)
 	destroy_workqueue(di->charger_wq);
 
 	flush_scheduled_work();
-	if(di->usb_chg.enabled)
+	if (di->usb_chg.enabled)
 		power_supply_unregister(&di->usb_chg.psy);
 #if !defined(CONFIG_CHARGER_PM2301)
-	if(di->ac_chg.enabled)
+	if (di->ac_chg.enabled)
 		power_supply_unregister(&di->ac_chg.psy);
 #endif
 	platform_set_drvdata(pdev, NULL);
@@ -3331,7 +3331,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Register AC charger class */
-	if(di->ac_chg.enabled) {
+	if (di->ac_chg.enabled) {
 		ret = power_supply_register(di->dev, &di->ac_chg.psy);
 		if (ret) {
 			dev_err(di->dev, "failed to register AC charger\n");
@@ -3340,7 +3340,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Register USB charger class */
-	if(di->usb_chg.enabled) {
+	if (di->usb_chg.enabled) {
 		ret = power_supply_register(di->dev, &di->usb_chg.psy);
 		if (ret) {
 			dev_err(di->dev, "failed to register USB charger\n");
@@ -3425,10 +3425,10 @@ free_irq:
 put_usb_phy:
 	usb_put_phy(di->usb_phy);
 free_usb:
-	if(di->usb_chg.enabled)
+	if (di->usb_chg.enabled)
 		power_supply_unregister(&di->usb_chg.psy);
 free_ac:
-	if(di->ac_chg.enabled)
+	if (di->ac_chg.enabled)
 		power_supply_unregister(&di->ac_chg.psy);
 free_charger_wq:
 	destroy_workqueue(di->charger_wq);
-- 
1.7.10.4
