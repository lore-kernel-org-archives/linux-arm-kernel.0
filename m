From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 26 Mar 2018 16:46:29 +0800
Subject: [PATCH 3/3] iio: adc: meson-axg: add saradc driver
In-Reply-To: <20180326084629.100070-1-yixun.lan@amlogic.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
Message-ID: <20180326084629.100070-4-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add the SAR ADC driver for the Amlogic Meson-AXG SoC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 799ed929ab99..a5d481a2b4ef 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -935,6 +935,11 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
 	.name = "meson-gxm-saradc",
 };
 
+static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
+	.param = &meson_sar_adc_gxl_param,
+	.name = "meson-axg-saradc",
+};
+
 static const struct of_device_id meson_sar_adc_of_match[] = {
 	{
 		.compatible = "amlogic,meson8-saradc",
@@ -953,6 +958,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 	}, {
 		.compatible = "amlogic,meson-gxm-saradc",
 		.data = &meson_sar_adc_gxm_data,
+	}, {
+		.compatible = "amlogic,meson-axg-saradc",
+		.data = &meson_sar_adc_axg_data,
 	},
 	{},
 };
-- 
2.15.1
