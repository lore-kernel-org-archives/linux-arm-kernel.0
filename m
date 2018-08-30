From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:44:56 +0200
Subject: [PATCH v3 08/30] iio: adc: remove hwmon structure
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-9-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We remove the hwmon structure that was requiered for the mfd driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index f787442a9e5f..ab474ce86fb6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -109,14 +109,6 @@ struct sun4i_gpadc_iio {
 	struct device			*sensor_device;
 };
 
-static struct iio_map sun4i_gpadc_hwmon_maps[] = {
-	{
-		.adc_channel_label = "temp_adc",
-		.consumer_dev_name = "iio_hwmon.0",
-	},
-	{ /* sentinel */ },
-};
-
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
 	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
 	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
-- 
2.11.0
