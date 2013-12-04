From: voice.shen@atmel.com (Bo Shen)
Date: Wed,  4 Dec 2013 10:37:04 +0800
Subject: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in DSP A mode
In-Reply-To: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
References: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1386124624-22414-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change sam9x5 with wm8731 work in DSP A mode, this will fix the
left/right channel swap issue.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/sam9x5_wm8731.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 992ae38..06c1811 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -107,7 +107,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	dai->stream_name = "WM8731 PCM";
 	dai->codec_dai_name = "wm8731-hifi";
 	dai->init = sam9x5_wm8731_init;
-	dai->dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+	dai->dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF
 		| SND_SOC_DAIFMT_CBM_CFM;
 
 	ret = snd_soc_of_parse_card_name(card, "atmel,model");
-- 
1.7.9.5
