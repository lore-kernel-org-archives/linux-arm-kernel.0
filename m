From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Jan 2018 15:33:17 +0000
Subject: Applied "IIO: ADC: stm32_dfsdm_stop_filter() can be static" to the
 asoc tree
In-Reply-To: <20180110152305.GA83560@lkp-sb05>
Message-ID: <E1eZINR-00056S-N9@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   IIO: ADC: stm32_dfsdm_stop_filter() can be static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1c4d0c5bc347328b257740d060ce9dbf48eebfe0 Mon Sep 17 00:00:00 2001
From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 10 Jan 2018 23:23:05 +0800
Subject: [PATCH] IIO: ADC: stm32_dfsdm_stop_filter() can be static

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index b03ca3f94331..e628d04d5c77 100644
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
-- 
2.15.1
