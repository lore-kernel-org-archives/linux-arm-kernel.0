From: broonie@kernel.org (Mark Brown)
Date: Tue, 07 Mar 2017 14:33:07 +0100
Subject: Applied "ASoC: sirf: Added blank line after declarations" to the asoc
 tree
In-Reply-To: <1488052773-9845-1-git-send-email-codrut.cristian.grosu@gmail.com>
Message-ID: <E1clFEh-0005VC-7m@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sirf: Added blank line after declarations

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

>From adbdba3fa1b618376363db317324c69d8ce5659c Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 21:59:33 +0200
Subject: [PATCH] ASoC: sirf: Added blank line after declarations

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sirf/sirf-audio-port.c | 1 +
 sound/soc/sirf/sirf-audio.c      | 1 +
 sound/soc/sirf/sirf-usp.c        | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/sound/soc/sirf/sirf-audio-port.c b/sound/soc/sirf/sirf-audio-port.c
index 3f2cce03275c..be066de74aaa 100644
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
index 94ea152e0362..f2bc50790f76 100644
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
index 45fc06c0e0e5..77e7dcf969d0 100644
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
@@ -294,6 +295,7 @@ static struct snd_soc_dai_driver sirf_usp_pcm_dai = {
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
2.11.0
