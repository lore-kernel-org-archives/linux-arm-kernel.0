From: jagan@openedev.com (Jagan Teki)
Date: Wed, 22 Mar 2017 16:36:46 +0530
Subject: [PATCH v7 1/3] Input: max11801_ts: Add missing of_match_table
Message-ID: <1490180808-2856-1-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Added missing of_match_table for max11801_ts driver with
compatible as "maxim,max11801_ts"

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v7:
- newly added patch

 drivers/input/touchscreen/max11801_ts.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index a595ae5..5085d4f 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -224,9 +224,16 @@ static int max11801_ts_probe(struct i2c_client *client,
 };
 MODULE_DEVICE_TABLE(i2c, max11801_ts_id);
 
+static const struct of_device_id max11801_ts_dt_ids[] = {
+	{ .compatible = "maxim,max11801_ts" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max11801_ts_dt_ids);
+
 static struct i2c_driver max11801_ts_driver = {
 	.driver = {
 		.name	= "max11801_ts",
+		.of_match_table	= max11801_ts_dt_ids,
 	},
 	.id_table	= max11801_ts_id,
 	.probe		= max11801_ts_probe,
-- 
1.9.1
