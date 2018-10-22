From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 22 Oct 2018 17:10:45 +0200
Subject: [PATCH 1/2] ASoC: stm32: add clock dependency for sai
In-Reply-To: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
References: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1540221046-11812-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")

Add COMMON_CLK dependency for STM32 SAI,
as it is required by clock provider.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 9b2681397dba..c66ffa72057e 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -3,6 +3,7 @@ menu "STMicroelectronics STM32 SOC audio support"
 config SND_SOC_STM32_SAI
 	tristate "STM32 SAI interface (Serial Audio Interface) support"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	depends on COMMON_CLK
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
-- 
2.7.4
