From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jul 2018 12:50:47 +0100 (BST)
Subject: Applied "ASoC: meson: axg-spdifout: select SND_PCM_IEC958" to the
 asoc tree
In-Reply-To: <20180724093705.1691747-1-arnd@arndb.de>
Message-ID: <20180724115047.72DDE440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: meson: axg-spdifout: select SND_PCM_IEC958

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

>From a241c3d95b8b985834d218eedde3923ed683e862 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Jul 2018 11:36:45 +0200
Subject: [PATCH] ASoC: meson: axg-spdifout: select SND_PCM_IEC958

When CONFIG_SND_PCM_IEC958 is disabled, we get a link error for the
new driver:

sound/soc/meson/axg-spdifout.o: In function `axg_spdifout_hw_params':
axg-spdifout.c:(.text+0x650): undefined reference to `snd_pcm_create_iec958_consumer_hw_params'

The other users use 'select', so we should do the same here.

Fixes: 53eb4b7aaa04 ("ASoC: meson: add axg spdif output")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 4cf93c05a982..8af8bc358a90 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -56,6 +56,7 @@ config SND_MESON_AXG_SOUND_CARD
 
 config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
+	select SND_PCM_IEC958
 	imply SND_SOC_SPDIF
 	help
 	  Select Y or M to add support for SPDIF output serializer embedded
-- 
2.18.0
