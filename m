From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Jun 2010 14:51:13 +0200
Subject: [PATCH] wm97xx_batt: Remove deprecated method to set pdata
Message-ID: <1276347073-3055-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/power/wm97xx_battery.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index 4e8afce..5071d85 100644
--- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -29,7 +29,6 @@ static DEFINE_MUTEX(bat_lock);
 static struct work_struct bat_work;
 static struct mutex work_lock;
 static int bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
-static struct wm97xx_batt_info *gpdata;
 static enum power_supply_property *prop;
 
 static unsigned long wm97xx_read_bat(struct power_supply *bat_ps)
@@ -172,12 +171,6 @@ static int __devinit wm97xx_bat_probe(struct platform_device *dev)
 	struct wm97xx_pdata *wmdata = dev->dev.platform_data;
 	struct wm97xx_batt_pdata *pdata;
 
-	if (gpdata) {
-		dev_err(&dev->dev, "Do not pass platform_data through "
-			"wm97xx_bat_set_pdata!\n");
-		return -EINVAL;
-	}
-
 	if (!wmdata) {
 		dev_err(&dev->dev, "No platform data supplied\n");
 		return -EINVAL;
@@ -308,15 +301,6 @@ static void __exit wm97xx_bat_exit(void)
 	platform_driver_unregister(&wm97xx_bat_driver);
 }
 
-/* The interface is deprecated, as well as linux/wm97xx_batt.h */
-void wm97xx_bat_set_pdata(struct wm97xx_batt_info *data);
-
-void wm97xx_bat_set_pdata(struct wm97xx_batt_info *data)
-{
-	gpdata = data;
-}
-EXPORT_SYMBOL_GPL(wm97xx_bat_set_pdata);
-
 module_init(wm97xx_bat_init);
 module_exit(wm97xx_bat_exit);
 
-- 
1.7.1
