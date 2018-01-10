From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 10 Jan 2018 23:23:05 +0800
Subject: [RFC PATCH asoc] IIO: ADC: stm32_dfsdm_stop_filter() can be static
In-Reply-To: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
References: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
Message-ID: <20180110152305.GA83560@lkp-sb05>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 stm32-dfsdm-adc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index b03ca3f..e628d04 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -254,7 +254,7 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm,
 				  DFSDM_CR1_RSWSTART(1));
 }
 
-void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
+static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
 {
 	/* Disable conversion */
 	regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
@@ -296,9 +296,9 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm,
 				  DFSDM_CR1_RSYNC(fl->sync_mode));
 }
 
-int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
-				 struct iio_dev *indio_dev,
-				 struct iio_chan_spec *ch)
+static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
+					struct iio_dev *indio_dev,
+					struct iio_chan_spec *ch)
 {
 	struct stm32_dfsdm_channel *df_ch;
 	const char *of_str;
