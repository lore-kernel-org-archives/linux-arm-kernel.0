From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:44:53 +0200
Subject: [PATCH v3 05/30] iio: adc: move SUN4I_GPADC_CHANNEL define to header
 file
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-6-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are moving the SUN4I_GPADC_CHANNEL define to the header file.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
 include/linux/mfd/sun4i-gpadc.h   | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d95dd0fde2a6..666329940e1e 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -109,15 +109,6 @@ struct sun4i_gpadc_iio {
 	struct device			*sensor_device;
 };
 
-#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
-	.type = IIO_VOLTAGE,					\
-	.indexed = 1,						\
-	.channel = _channel,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-	.datasheet_name = _name,				\
-}
-
 static struct iio_map sun4i_gpadc_hwmon_maps[] = {
 	{
 		.adc_channel_label = "temp_adc",
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 139872c2e0fe..54c7c9375c1b 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -90,6 +90,15 @@
 /* 10s delay before suspending the IP */
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
 
+#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = _name,				\
+}
+
 struct sun4i_gpadc_dev {
 	struct device			*dev;
 	struct regmap			*regmap;
-- 
2.11.0
