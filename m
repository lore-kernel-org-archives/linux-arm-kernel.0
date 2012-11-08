From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Nov 2012 18:01:52 +0100
Subject: [PATCH 2/3] gpio: pca953x: Add compatible strings to gpio-pca953x
 driver
In-Reply-To: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1352394113-19513-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though the device tree binding code was already written, the
compatible strings were not yet in the driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpio/gpio-pca953x.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 5ba7e60..0c5eaf5 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -765,9 +765,38 @@ static int pca953x_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id pca953x_dt_ids[] = {
+	{ .compatible = "nxp,pca9534", },
+	{ .compatible = "nxp,pca9535", },
+	{ .compatible = "nxp,pca9536", },
+	{ .compatible = "nxp,pca9537", },
+	{ .compatible = "nxp,pca9538", },
+	{ .compatible = "nxp,pca9539", },
+	{ .compatible = "nxp,pca9554", },
+	{ .compatible = "nxp,pca9555", },
+	{ .compatible = "nxp,pca9556", },
+	{ .compatible = "nxp,pca9557", },
+	{ .compatible = "nxp,pca9574", },
+	{ .compatible = "nxp,pca9575", },
+
+	{ .compatible = "maxim,max7310", },
+	{ .compatible = "maxim,max7312", },
+	{ .compatible = "maxim,max7313", },
+	{ .compatible = "maxim,max7315", },
+
+	{ .compatible = "ti,pca6107", },
+	{ .compatible = "ti,tca6408", },
+	{ .compatible = "ti,tca6416", },
+	{ .compatible = "ti,tca6424", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, pca953x_dt_ids);
+
 static struct i2c_driver pca953x_driver = {
 	.driver = {
 		.name	= "pca953x",
+		.of_match_table = pca953x_dt_ids,
 	},
 	.probe		= pca953x_probe,
 	.remove		= pca953x_remove,
-- 
1.7.9.5
