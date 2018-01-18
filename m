From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Jan 2018 12:17:47 +0100
Subject: [PATCH] [v2] IIO: ADC: stm32-dfsdm: remove unused variable again
Message-ID: <20180118111810.378441-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The merge between commit abaca806fd13 ("IIO: ADC: stm32-dfsdm: code
optimization") and commit 2353758bc2d4 ("IIO: ADC: stm32-dfsdm: avoid
unused-variable warning") left one variable behind that is no longer
needed and can be removed, as shown by the gcc warning:

drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
drivers/iio/adc/stm32-dfsdm-core.c:245:29: error: unused variable 'of_id' [-Werror=unused-variable]

Fixes: d84b4c7c706f ("Merge branch 'topic/iio' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into asoc-st-dfsdm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: update patch description to point to the merge rather than
the correct commit before it.
---
 drivers/iio/adc/stm32-dfsdm-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 84277bcc465f..6290332cfd3f 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 static int stm32_dfsdm_probe(struct platform_device *pdev)
 {
 	struct dfsdm_priv *priv;
-	const struct of_device_id *of_id;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct stm32_dfsdm *dfsdm;
 	int ret;
-- 
2.9.0
