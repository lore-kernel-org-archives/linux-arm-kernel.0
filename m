From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Oct 2018 11:54:04 +0200 (CEST)
Subject: Applied "ASoC: stm32: add clock dependency for sai" to the asoc tree
In-Reply-To: <1540221046-11812-2-git-send-email-olivier.moysan@st.com>
Message-ID: <20181023095404.C9F7F440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: add clock dependency for sai

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

>From e6d7942ce602e99d506a7c08f1935a274645dfda Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 22 Oct 2018 17:10:45 +0200
Subject: [PATCH] ASoC: stm32: add clock dependency for sai

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")

Add COMMON_CLK dependency for STM32 SAI,
as it is required by clock provider.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0
