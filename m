From: chrisadr@gentoo.org (=?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?=)
Date: Thu, 18 Jan 2018 18:44:15 -0500
Subject: [PATCH-next] IIO: ADC: drop unused 'of_id' struct
Message-ID: <20180118234415.32410-1-chrisadr@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_STM32_DFSDM_CORE is enabled, stm32-dfsdm-core.o is compiled,
which raises a next warning:

drivers/iio/adc/stm32-dfsdm-core.c: In function ?stm32_dfsdm_probe?:
drivers/iio/adc/stm32-dfsdm-core.c:245:29: warning: unused variable ?of_id? [-Wunused-variable]
  const struct of_device_id *of_id;
                             ^~~~~

Signed-off-by: Christopher D?az Riveros <chrisadr@gentoo.org>
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
2.15.1
