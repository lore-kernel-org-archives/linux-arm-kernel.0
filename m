From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 23 Feb 2018 13:50:55 +0100
Subject: [PATCH 1/7] iio: adc: stm32-dfsdm: fix compatible data use
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1519390261-25453-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix use of compatible data: stm32h7 regmap configuration is statically
used. Rather use regmap_cfg from compatible data.

Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 6290332..0635f93 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -274,7 +274,7 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 
 	dfsdm->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "dfsdm",
 						  dfsdm->base,
-						  &stm32h7_dfsdm_regmap_cfg);
+						  dev_data->regmap_cfg);
 	if (IS_ERR(dfsdm->regmap)) {
 		ret = PTR_ERR(dfsdm->regmap);
 		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
-- 
1.9.1
