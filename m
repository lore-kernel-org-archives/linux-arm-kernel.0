From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 30 Jan 2015 17:38:42 +0800
Subject: [PATCH 1/3] ASoC: atmel_ssc_dai: fix the setting for DSP mode
In-Reply-To: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
References: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1422610724-7222-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When SCC work in DSP A mode, the data outputs/inputs are shift out on
falling edge, the frame sync are sample on the rising edge.

Reported-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 sound/soc/atmel/atmel_ssc_dai.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 99ff35e..c1d93b8 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -512,7 +512,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
 			| SSC_BF(RCMR_STTDLY, 1)
 			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKI, SSC_CKI_FALLING)
 			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
 			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
 
@@ -527,7 +527,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
 			| SSC_BF(TCMR_STTDLY, 1)
 			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
 			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
 			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
 
@@ -556,7 +556,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKI, SSC_CKI_FALLING)
 			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
 			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
 					   SSC_CKS_PIN : SSC_CKS_CLOCK);
-- 
2.3.0.rc0
