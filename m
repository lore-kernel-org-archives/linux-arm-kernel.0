From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 23:02:04 +0100
Subject: [PATCH RESEND] ASoC: pxa: remove unused variable
Message-ID: <1456437736-732609-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pointed out by Zhangfei Gao, the sspa_div variable in
brownstone_wm8994_hw_params() is completely unused, so as a cleanup
following a prior patch, this removes both the variable and the division.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Submitted originally on Nov 23 2015, this apparently got lost,
resending it now.

 sound/soc/pxa/brownstone.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 416ea646c3b1..ec522e94b0e2 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -52,7 +52,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int freq_out, sspa_mclk, sysclk;
-	int sspa_div;
 
 	if (params_rate(params) > 11025) {
 		freq_out  = params_rate(params) * 512;
@@ -63,7 +62,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 		sysclk    = params_rate(params) * 512;
 		sspa_mclk = params_rate(params) * 64;
 	}
-	sspa_div = freq_out / sspa_mclk;
 
 	snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
 	snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
-- 
2.7.0
