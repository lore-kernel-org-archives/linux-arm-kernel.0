From: krishna.md@samsung.com (Krishna Mohan Dani)
Date: Tue, 11 Nov 2014 14:28:24 +0530
Subject: [PATCH 4/4] ASoC: rt5631: Adding Device Tree compatibility to
 Realtek's ALC5631 codec driver
In-Reply-To: <1415696304-12023-1-git-send-email-krishna.md@samsung.com>
References: <1415696304-12023-1-git-send-email-krishna.md@samsung.com>
Message-ID: <1415696304-12023-5-git-send-email-krishna.md@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
---
 sound/soc/codecs/rt5631.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 1ba27db..101b205 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1686,10 +1686,18 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5631 = {
 
 static const struct i2c_device_id rt5631_i2c_id[] = {
 	{ "rt5631", 0 },
+	{ "alc5631", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5631_i2c_id);
 
+static struct of_device_id rt5631_i2c_dt_ids[] = {
+	{ .compatible = "realtek,rt5631"},
+	{ .compatible = "realtek,alc5631"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5631_i2c_dt_ids);
+
 static const struct regmap_config rt5631_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -1734,6 +1742,9 @@ static struct i2c_driver rt5631_i2c_driver = {
 	.driver = {
 		.name = "rt5631",
 		.owner = THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = of_match_ptr(rt5631_i2c_dt_ids),
+#endif
 	},
 	.probe = rt5631_i2c_probe,
 	.remove   = rt5631_i2c_remove,
-- 
1.7.9.5
