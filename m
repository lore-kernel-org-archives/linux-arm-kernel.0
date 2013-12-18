From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 18 Dec 2013 11:26:23 +0800
Subject: [PATCH] ASoC: wm8904: fix DSP mode B configuration
Message-ID: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When wm8904 work in DSP mode B, we still need to configure it to
work in DSP mode. Or else, it will work in Right Justified mode.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/codecs/wm8904.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 3938fb1..53bbfac 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1444,7 +1444,7 @@ static int wm8904_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
-		aif1 |= WM8904_AIF_LRCLK_INV;
+		aif1 |= 0x3 | WM8904_AIF_LRCLK_INV;
 	case SND_SOC_DAIFMT_DSP_A:
 		aif1 |= 0x3;
 		break;
-- 
1.7.9.5
