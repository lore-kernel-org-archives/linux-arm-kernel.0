From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Apr 2016 11:26:29 +0100
Subject: Applied "ASoC: mediatek: HDMI audio LR channel swapped" to the asoc
 tree
In-Reply-To: <1461652218-52215-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <E1av0CL-0006yr-Sf@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: HDMI audio LR channel swapped

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

>From 27becea06e73c96b825ecddd8b3a59642364514a Mon Sep 17 00:00:00 2001
From: PC Liao <pc.liao@mediatek.com>
Date: Tue, 26 Apr 2016 14:30:18 +0800
Subject: [PATCH] ASoC: mediatek: HDMI audio LR channel swapped

Because LRCK of TDM use High to Low as default setting, this patch
changes the TDM setting to inverse LRCK.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mtk-afe-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index f1c58a2c12fb..2b5df2ef51a3 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -123,6 +123,7 @@
 #define AFE_TDM_CON1_WLEN_32BIT		(0x2 << 8)
 #define AFE_TDM_CON1_MSB_ALIGNED	(0x1 << 4)
 #define AFE_TDM_CON1_1_BCK_DELAY	(0x1 << 3)
+#define AFE_TDM_CON1_LRCK_INV		(0x1 << 2)
 #define AFE_TDM_CON1_BCK_INV		(0x1 << 1)
 #define AFE_TDM_CON1_EN			(0x1 << 0)
 
@@ -449,6 +450,7 @@ static int mtk_afe_hdmi_prepare(struct snd_pcm_substream *substream,
 			      runtime->rate * runtime->channels * 32);
 
 	val = AFE_TDM_CON1_BCK_INV |
+	      AFE_TDM_CON1_LRCK_INV |
 	      AFE_TDM_CON1_1_BCK_DELAY |
 	      AFE_TDM_CON1_MSB_ALIGNED | /* I2S mode */
 	      AFE_TDM_CON1_WLEN_32BIT |
-- 
2.8.0.rc3
