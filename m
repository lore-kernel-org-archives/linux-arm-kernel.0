From: cychiang@chromium.org (Cheng-Yi Chiang)
Date: Fri, 16 Sep 2016 07:10:06 +0800
Subject: [PATCH] ASoC: rockchip: Support headset button function on rk3399
Message-ID: <1473981006-20542-1-git-send-email-cychiang@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the mapping between button and media key event.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 164b6da..ee06489 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -23,6 +23,7 @@
 #include <linux/of_gpio.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/input.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -209,6 +210,14 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	snd_jack_set_key(rockchip_sound_jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(
+		rockchip_sound_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(
+		rockchip_sound_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(
+		rockchip_sound_jack.jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+
 	da7219_aad_jack_det(codec, &rockchip_sound_jack);
 
 	return 0;
-- 
2.6.6
