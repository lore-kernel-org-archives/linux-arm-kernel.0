From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 23:20:30 +0200
Subject: [PATCH] ASoC: pxa: Added */ to the next line
Message-ID: <1488057630-14575-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/hx4700.c     | 3 ++-
 sound/soc/pxa/pxa-ssp.c    | 3 ++-
 sound/soc/pxa/pxa2xx-pcm.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 8548304..17c2e67 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -70,7 +70,8 @@ static int hx4700_hw_params(struct snd_pcm_substream *substream,
 		return ret;

 	/* inform codec driver about clock freq *
-	 * (PXA I2S always uses divider 256)    */
+	 * (PXA I2S always uses divider 256)
+	 */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 256 * params_rate(params),
 			SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3cad990..3bdace6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -254,7 +254,8 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	}

 	/* The SSP clock must be disabled when changing SSP clock mode
-	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
+	 * on PXA2xx.  On PXA3xx it must be enabled when doing so.
+	 */
 	if (ssp->type != PXA3xx_SSP)
 		clk_disable_unprepare(ssp->clk);
 	val = pxa_ssp_read_reg(ssp, SSCR0) | sscr0;
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index b51d7a0..3926cd8 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -31,7 +31,8 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	dma = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);

 	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	 * codec <--> BT codec or GSM modem -- lg
+	 */
 	if (!dma)
 		return 0;

--
1.9.1
