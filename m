From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 17:26:22 +0000
Subject: Applied "ASoC: samsung: Enable COMPILE_TEST for SmartQ and WM8580" to
 the asoc tree
In-Reply-To: <1479566911-5580-5-git-send-email-krzk@kernel.org>
Message-ID: <E1c9Epq-0005lX-10@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: samsung: Enable COMPILE_TEST for SmartQ and WM8580

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 95f5609d223d661419061bd6231da01a317c30d9 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 20 Nov 2016 21:24:53 +0200
Subject: [PATCH] ASoC: samsung: Enable COMPILE_TEST for SmartQ and WM8580

The I2S sound drivers for SmartQ board and WM8580 codec can be compile
tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 48dcd3dd9ec7..a6cc6ca93fa7 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -50,7 +50,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on MACH_SMDK6410
+	depends on MACH_SMDK6410 || COMPILE_TEST
 	depends on I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
@@ -110,7 +110,8 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 
 config SND_SOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
-	depends on MACH_SMARTQ && I2C
+	depends on MACH_SMARTQ || COMPILE_TEST
+	depends on I2C
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8750
 
-- 
2.10.2
