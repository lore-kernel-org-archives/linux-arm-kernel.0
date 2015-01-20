From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 20 Jan 2015 15:43:17 +0800
Subject: [PATCH v2 2/2] ASoC: atmel_ssc_dai: remove clock pin comments
In-Reply-To: <1421739797-25988-1-git-send-email-voice.shen@atmel.com>
References: <1421739797-25988-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1421739797-25988-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the clock can be get from TK/RK pin, so remove the comments.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

Changes in v2:
 - remove the comments for DSP mode A, codec as master

 sound/soc/atmel/atmel_ssc_dai.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index e691aab..3cd7059 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -450,13 +450,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		break;
 
 	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
-		/*
-		 * I2S format, CODEC supplies BCLK and LRC clocks.
-		 *
-		 * The SSC transmit clock is obtained from the BCLK signal on
-		 * on the TK line, and the SSC receive clock is
-		 * generated from the transmit clock.
-		 */
+		/* I2S format, CODEC supplies BCLK and LRC clocks. */
 		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
@@ -535,10 +529,6 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		/*
 		 * DSP/PCM Mode A format, CODEC supplies BCLK and LRC clocks.
 		 *
-		 * The SSC transmit clock is obtained from the BCLK signal on
-		 * on the TK line, and the SSC receive clock is
-		 * generated from the transmit clock.
-		 *
 		 * Data is transferred on first BCLK after LRC pulse rising
 		 * edge.If stereo, the right channel data is contiguous with
 		 * the left channel data.
-- 
2.3.0.rc0
