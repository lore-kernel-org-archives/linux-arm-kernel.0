From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 15 Jan 2018 10:00:26 +0100
Subject: [PATCH] IIO: ADC: stm32-dfsdm: fix static check warning
Message-ID: <1516006826-16230-1-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iio_priv does not return an error pointer, so check is not valid.
Patch suppresses it.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index f79a90f..5c67236 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1099,10 +1099,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	}
 
 	adc = iio_priv(iio);
-	if (IS_ERR(adc)) {
-		dev_err(dev, "%s: Failed to allocate ADC\n", __func__);
-		return PTR_ERR(adc);
-	}
 	adc->dfsdm = dev_get_drvdata(dev->parent);
 
 	iio->dev.parent = dev;
-- 
2.7.4
