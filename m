From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 21:59:33 +0200
Subject: [PATCH] ASoC: sirf: Added blank line after declarations
Message-ID: <1488052773-9845-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/sirf/sirf-audio-port.c | 1 +
 sound/soc/sirf/sirf-audio.c      | 1 +
 sound/soc/sirf/sirf-usp.c        | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/sound/soc/sirf/sirf-audio-port.c b/sound/soc/sirf/sirf-audio-port.c
index 3f2cce0..be066de 100644
--- a/sound/soc/sirf/sirf-audio-port.c
+++ b/sound/soc/sirf/sirf-audio-port.c
@@ -19,6 +19,7 @@ struct sirf_audio_port {
 static int sirf_audio_port_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sirf_audio_port *port = snd_soc_dai_get_drvdata(dai);
+
 	snd_soc_dai_init_dma_data(dai, &port->playback_dma_data,
 			&port->capture_dma_data);
 	return 0;
diff --git a/sound/soc/sirf/sirf-audio.c b/sound/soc/sirf/sirf-audio.c
index 94ea152..f2bc507 100644
--- a/sound/soc/sirf/sirf-audio.c
+++ b/sound/soc/sirf/sirf-audio.c
@@ -27,6 +27,7 @@ static int sirf_audio_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_card *card = dapm->card;
 	struct sirf_audio_card *sirf_audio_card = snd_soc_card_get_drvdata(card);
 	int on = !SND_SOC_DAPM_EVENT_OFF(event);
+
 	if (gpio_is_valid(sirf_audio_card->gpio_hp_pa))
 		gpio_set_value(sirf_audio_card->gpio_hp_pa, on);
 	return 0;
diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
index 45fc06c..77e7dcf 100644
--- a/sound/soc/sirf/sirf-usp.c
+++ b/sound/soc/sirf/sirf-usp.c
@@ -71,6 +71,7 @@ static void sirf_usp_rx_disable(struct sirf_usp *usp)
 static int sirf_usp_pcm_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sirf_usp *usp = snd_soc_dai_get_drvdata(dai);
+
 	snd_soc_dai_init_dma_data(dai, &usp->playback_dma_data,
 			&usp->capture_dma_data);
 	return 0;
@@ -294,6 +295,7 @@ static int sirf_usp_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 static int sirf_usp_pcm_runtime_suspend(struct device *dev)
 {
 	struct sirf_usp *usp = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(usp->clk);
 	return 0;
 }
@@ -302,6 +304,7 @@ static int sirf_usp_pcm_runtime_resume(struct device *dev)
 {
 	struct sirf_usp *usp = dev_get_drvdata(dev);
 	int ret;
+
 	ret = clk_prepare_enable(usp->clk);
 	if (ret) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
--
1.9.1
