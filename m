From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 23 Feb 2018 13:50:56 +0100
Subject: [PATCH 2/7] iio: adc: stm32-dfsdm: fix call to stop channel
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1519390261-25453-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32_dfsdm_stop_channel must be called with channel id, not filter id.

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index daa026d..0eff811 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -464,7 +464,7 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc, bool dma)
 
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_RCONT_MASK, 0);
-	stm32_dfsdm_stop_channel(adc->dfsdm, adc->fl_id);
+	stm32_dfsdm_stop_channel(adc->dfsdm, adc->ch_id);
 
 	return ret;
 }
-- 
1.9.1
