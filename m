From: broonie@kernel.org (Mark Brown)
Date: Wed,  1 Aug 2018 12:16:59 +0100 (BST)
Subject: Applied "ASoC: stm32: remove redundant pointers 'priv' and 'rtd'" to
 the asoc tree
In-Reply-To: <20180801104742.4328-8-colin.king@canonical.com>
Message-ID: <20180801111659.6C39F1124241@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: remove redundant pointers 'priv' and 'rtd'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 18127744cf446f113ca33f07e5cea893388f781a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 1 Aug 2018 11:47:40 +0100
Subject: [PATCH] ASoC: stm32: remove redundant pointers 'priv' and 'rtd'

Pointer 'priv' is assigned and not used, removing this allows
the removal of pointer 'rtd'.

Cleans up clang warning:
warning: variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 0e9373064032..706ff005234f 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -269,16 +269,10 @@ static int stm32_adfsdm_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static void stm32_adfsdm_pcm_free(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
-	struct snd_soc_pcm_runtime *rtd;
-	struct stm32_adfsdm_priv *priv;
 
 	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-	if (substream) {
-		rtd = substream->private_data;
-		priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-
+	if (substream)
 		snd_pcm_lib_preallocate_free_for_all(pcm);
-	}
 }
 
 static struct snd_soc_component_driver stm32_adfsdm_soc_platform = {
-- 
2.18.0
