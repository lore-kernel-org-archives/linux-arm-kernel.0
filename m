From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 22:51:11 +0100
Subject: [PATCH 6/9] power: pm2301_charger: remove __devinit annotations
In-Reply-To: <1363902674-6456-1-git-send-email-arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
Message-ID: <1363902674-6456-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These got missed in the treewide changes because they came in through
a new branch, and it now breaks allmodconfig builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/pm2301_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index ed48d75..ca424b8 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -851,7 +851,7 @@ static int pm2xxx_wall_charger_suspend(struct i2c_client *i2c_client,
 	return 0;
 }
 
-static int __devinit pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
+static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 		const struct i2c_device_id *id)
 {
 	struct pm2xxx_platform_data *pl_data = i2c_client->dev.platform_data;
@@ -1021,7 +1021,7 @@ free_device_info:
 	return ret;
 }
 
-static int __devexit pm2xxx_wall_charger_remove(struct i2c_client *i2c_client)
+static int pm2xxx_wall_charger_remove(struct i2c_client *i2c_client)
 {
 	struct pm2xxx_charger *pm2 = i2c_get_clientdata(i2c_client);
 
@@ -1058,7 +1058,7 @@ MODULE_DEVICE_TABLE(i2c, pm2xxx_id);
 
 static struct i2c_driver pm2xxx_charger_driver = {
 	.probe = pm2xxx_wall_charger_probe,
-	.remove = __devexit_p(pm2xxx_wall_charger_remove),
+	.remove = pm2xxx_wall_charger_remove,
 	.suspend = pm2xxx_wall_charger_suspend,
 	.resume = pm2xxx_wall_charger_resume,
 	.driver = {
-- 
1.8.1.2
