From: sangsu4u.park@samsung.com (=?ks_c_5601-1987?B?udq787z2?=)
Date: Sun, 26 Aug 2012 17:45:54 +0900
Subject: [PATCH] ASoC: SAMSUNG: Add SND_SOC_DAIFMT_CONT option for
 snd_soc_set_fmt()
Message-ID: <003101cd8367$3476e650$9d64b2f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_SOC_DAIFMT_CONT option is now needed because of below commit:

ASoC: Allow DAI formats to be specified in the dai_link

Otherwise, s3c_pcm_set_fmt() returns -EINVAL.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
---
 sound/soc/samsung/smdk_wm8994pcm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 77ecba9..cb88cbc 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -77,6 +77,7 @@ static int smdk_wm8994_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	/* Set the cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_B
+				| SND_SOC_DAIFMT_CONT
 				| SND_SOC_DAIFMT_IB_NF
 				| SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
-- 
1.7.1
