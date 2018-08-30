From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:44:51 +0200
Subject: [PATCH v3 03/30] iio: adc: Remove ID table
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-4-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To disable the driver we are removing the compatibles.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 04d7147e0110..d95dd0fde2a6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -698,21 +698,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id sun4i_gpadc_id[] = {
-	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_data },
-	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_data },
-	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(platform, sun4i_gpadc_id);
-
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
 		.name = "sun4i-gpadc-iio",
 		.of_match_table = sun4i_gpadc_of_id,
 		.pm = &sun4i_gpadc_pm_ops,
 	},
-	.id_table = sun4i_gpadc_id,
 	.probe = sun4i_gpadc_probe,
 	.remove = sun4i_gpadc_remove,
 };
-- 
2.11.0
