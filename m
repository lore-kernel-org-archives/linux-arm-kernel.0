From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Sep 2016 18:39:41 +0100
Subject: Applied "ASoC: rockchip: Support headset button function on rk3399"
 to the asoc tree
In-Reply-To: <1473981006-20542-1-git-send-email-cychiang@chromium.org>
Message-ID: <E1bkx6z-0003yX-Rd@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Support headset button function on rk3399

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

>From 22b93eaf55edfd2f1fe9d1fc0d7338f582f12745 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Fri, 16 Sep 2016 07:10:06 +0800
Subject: [PATCH] ASoC: rockchip: Support headset button function on rk3399

Set the mapping between button and media key event.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 164b6da4f2cf..ee0648927afc 100644
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
2.8.1
