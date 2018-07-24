From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2018 11:36:45 +0200
Subject: [PATCH] ASoC: meson: axg-spdifout: select SND_PCM_IEC958
Message-ID: <20180724093705.1691747-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_SND_PCM_IEC958 is disabled, we get a link error for the
new driver:

sound/soc/meson/axg-spdifout.o: In function `axg_spdifout_hw_params':
axg-spdifout.c:(.text+0x650): undefined reference to `snd_pcm_create_iec958_consumer_hw_params'

The other users use 'select', so we should do the same here.

Fixes: 53eb4b7aaa04 ("ASoC: meson: add axg spdif output")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
