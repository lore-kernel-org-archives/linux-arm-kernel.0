From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 09:54:44 +0000
Subject: [PATCH 1/2] ASoC: ab8500: Revert "ASoC: ab8500: Explicitly set I/O up"
Message-ID: <1383731685-18441-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 2245e3c31c15c2d2a26926c4b734f4d3a37ae252, as it
is one of two patches which stop audio from working on Snowball.

Cc: alsa-devel at alsa-project.org
Cc: Mark Brown <broonie@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/ab8500-codec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index a0394a8..ca500fd 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2473,8 +2473,6 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 	dev_dbg(dev, "%s: Enter.\n", __func__);
 
-	snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
-
 	/* Setup AB8500 according to board-settings */
 	pdata = dev_get_platdata(dev->parent);
 
-- 
1.8.1.2
