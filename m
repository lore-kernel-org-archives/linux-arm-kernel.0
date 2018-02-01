From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 1 Feb 2018 09:54:41 +0100
Subject: [PATCH 1/1] ASoC: stm32: add of dependency for stm32 drivers
Message-ID: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of dependency for STM32 ASoC drivers.
DFSDM of dependency is already inherited
from STM32_DFSDM_ADC dependency.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 3ad881f..b5375f9 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -3,6 +3,7 @@ menu "STMicroelectronics STM32 SOC audio support"
 config SND_SOC_STM32_SAI
 	tristate "STM32 SAI interface (Serial Audio Interface) support"
 	depends on ARCH_STM32 || COMPILE_TEST
+	depends on OF
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -12,6 +13,7 @@ config SND_SOC_STM32_SAI
 config SND_SOC_STM32_I2S
 	tristate "STM32 I2S interface (SPI/I2S block) support"
 	depends on ARCH_STM32 || COMPILE_TEST
+	depends on OF
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -21,6 +23,7 @@ config SND_SOC_STM32_I2S
 config SND_SOC_STM32_SPDIFRX
 	tristate "STM32 S/PDIF receiver (SPDIFRX) support"
 	depends on ARCH_STM32 || COMPILE_TEST
+	depends on OF
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
-- 
1.9.1
