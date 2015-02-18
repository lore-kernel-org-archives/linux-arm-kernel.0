From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 19:25:55 +0100
Subject: [PATCH 2/6] ASoC: max98088: Add DT bindings
In-Reply-To: <1424283959-16289-1-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
Message-ID: <1424283959-16289-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"maxim,max98089" will be used for the Spring Chromebook.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 sound/soc/codecs/max98088.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 805b3f8cd39d..69a21d1946e3 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -2009,10 +2009,18 @@ static const struct i2c_device_id max98088_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
 
+static const struct of_device_id max98088_of_match[] = {
+	{ .compatible = "maxim,max98088" },
+	{ .compatible = "maxim,max98089" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max98088_of_match);
+
 static struct i2c_driver max98088_i2c_driver = {
 	.driver = {
 		.name = "max98088",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(max98088_of_match),
 	},
 	.probe  = max98088_i2c_probe,
 	.remove = max98088_i2c_remove,
-- 
2.1.4
