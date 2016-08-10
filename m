From: j-keerthy@ti.com (Keerthy)
Date: Wed, 10 Aug 2016 18:22:23 +0530
Subject: [PATCH v7 3/5] input: tps65218-pwrbutton: Add platform_device_id table
In-Reply-To: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
References: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1470833545-29462-4-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_device_id table is needed for adding the tps65218-pwrbutton
module to the mfd_cell array.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/tps65218-pwrbutton.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index 2bba8de..33d141a 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -113,12 +113,19 @@ static const struct of_device_id of_tps65218_pwr_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
 
+static const struct platform_device_id tps65218_pwrbtn_id_table[] = {
+	{ "tps65218-pwrbutton", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65218_pwrbtn_id_table);
+
 static struct platform_driver tps65218_pwron_driver = {
 	.probe	= tps65218_pwron_probe,
 	.driver	= {
 		.name	= "tps65218_pwrbutton",
 		.of_match_table = of_tps65218_pwr_match,
 	},
+	.id_table = tps65218_pwrbtn_id_table,
 };
 module_platform_driver(tps65218_pwron_driver);
 
-- 
1.9.1
