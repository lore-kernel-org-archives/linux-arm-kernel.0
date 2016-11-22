From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 17:26:34 +0000
Subject: Applied "ASoC: samsung: Remove non-existing MACH dependencies" to the
 asoc tree
In-Reply-To: <1479566911-5580-2-git-send-email-krzk@kernel.org>
Message-ID: <E1c9Eq2-0005p0-CW@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: samsung: Remove non-existing MACH dependencies

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

>From f8cbab42d98298ab9c4878dc9105d350b0b902ff Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 20 Nov 2016 21:24:51 +0200
Subject: [PATCH] ASoC: samsung: Remove non-existing MACH dependencies

MACH_SMDKC100 was removed in commit b8529ec1c1b0 ("ARM: S5PC100: no more
support S5PC100 SoC"). MACH_SMDKV210 and MACH_SMDKC110 in commit
28c8331d386 ("ARM: S5PV210: Remove support for board files").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 79ae6a7c93ff..ea0fa9971a0c 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -49,7 +49,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110
+	depends on MACH_SMDK6410
 	depends on I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
-- 
2.10.2
