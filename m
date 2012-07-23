From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:27 +0200
Subject: [PATCH 22/25] mfd/da9052: make i2c_device_id array const
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-23-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This is possible since *of_device_id.data became const. While at it also
drop a cast to const that was never needed.

[ukl: split Arnd's patch by driver and add changlog]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/da9052-i2c.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 82c9d64..352c58b 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -46,7 +46,7 @@ static int da9052_i2c_enable_multiwrite(struct da9052 *da9052)
 	return 0;
 }
 
-static struct i2c_device_id da9052_i2c_id[] = {
+static const struct i2c_device_id da9052_i2c_id[] = {
 	{"da9052", DA9052},
 	{"da9053-aa", DA9053_AA},
 	{"da9053-ba", DA9053_BA},
@@ -104,7 +104,7 @@ static int __devinit da9052_i2c_probe(struct i2c_client *client,
 		const struct of_device_id *deviceid;
 
 		deviceid = of_match_node(dialog_dt_ids, np);
-		id = (const struct i2c_device_id *)deviceid->data;
+		id = deviceid->data;
 	}
 #endif
 
-- 
1.7.10.4
