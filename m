From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Wed, 11 Oct 2017 09:35:32 +0300
Subject: [PATCH v2 5/5] iio: adc: at91-sama5d2_adc: use max sample rate
In-Reply-To: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1507703732-29175-6-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change driver settings to use maximum sample rate clock.
This is useful to achieve best possible sampling rate
if we use DMA.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 7e51ecb..b76f88f 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -934,7 +934,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
 	at91_adc_writel(st, AT91_SAMA5D2_MR,
 			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
 
-	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
+	at91_adc_setup_samp_freq(st, st->soc_info.max_sample_rate);
 }
 
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
-- 
2.7.4
