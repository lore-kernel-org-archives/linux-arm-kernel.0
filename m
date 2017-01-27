From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 27 Jan 2017 09:54:42 +0100
Subject: [PATCH v2 09/25] iio: adc: axp20x_adc: map acin_i and acin_v
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Message-ID: <20170127085458.18270-10-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This maps the IIO channels acin_i and acin_v (respectively exposing the
current current and voltage measures of the AC power supply) to the AC
power supply driver.

Only the AXP20X PMICs have these ADC channels and thus they are only
mapped for this version of the PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 drivers/iio/adc/axp20x_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index bacde92..14f4ec0 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -104,6 +104,14 @@ static struct iio_map axp20x_maps[] = {
 		.consumer_dev_name = "axp20x-usb-power-supply",
 		.consumer_channel = "vbus_i",
 		.adc_channel_label = "vbus_i",
+	}, {
+		.consumer_dev_name = "axp20x-ac-power-supply",
+		.consumer_channel = "acin_v",
+		.adc_channel_label = "acin_v",
+	}, {
+		.consumer_dev_name = "axp20x-ac-power-supply",
+		.consumer_channel = "acin_i",
+		.adc_channel_label = "acin_i",
 	}, { /* sentinel */ }
 };
 
-- 
2.9.3
