From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:44:54 +0200
Subject: [PATCH v3 06/30] iio: adc: remove ofnode options
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-7-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are merging the mfd dirver into the adc driver we don't need
two different probing functions. Thus we remove the ofnode options

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 666329940e1e..d6f00d3b802d 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -622,10 +622,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	indio_dev->info = &sun4i_gpadc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (pdev->dev.of_node)
-		ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
-	else
-		ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
+	ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
 
 	if (ret)
 		return ret;
-- 
2.11.0
