From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Feb 2018 11:17:28 +0000
Subject: Applied "ASoC: pxa: remove duplicated bit-wise or of
 SNDRV_PCM_FMTBIT_S24_LE" to the asoc tree
In-Reply-To: <20180223143738.29600-1-colin.king@canonical.com>
Message-ID: <E1eqGme-0005UW-4n@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: pxa: remove duplicated bit-wise or of SNDRV_PCM_FMTBIT_S24_LE

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

>From 8b597ff47053c9f53384a3a26dcc4c4316a375e5 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 23 Feb 2018 14:37:38 +0000
Subject: [PATCH] ASoC: pxa: remove duplicated bit-wise or of
 SNDRV_PCM_FMTBIT_S24_LE

Bit pattern SNDRV_PCM_FMTBIT_S24_LE is being bit-wise or'd twice; remove
the redundant 2nd SNDRV_PCM_FMTBIT_S24_LE

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mmp-sspa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 64b85e30c1f8..7c998ea4ebee 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -377,7 +377,6 @@ static int mmp_sspa_probe(struct snd_soc_dai *dai)
 #define MMP_SSPA_FORMATS (SNDRV_PCM_FMTBIT_S8 | \
 		SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S24_LE | \
-		SNDRV_PCM_FMTBIT_S24_LE | \
 		SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops mmp_sspa_dai_ops = {
-- 
2.16.1
