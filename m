From: pc.liao@mediatek.com (PC Liao)
Date: Tue, 26 Apr 2016 14:30:18 +0800
Subject: [PATCH] ASoC: mediatek: HDMI audio LR channel swapped
Message-ID: <1461652218-52215-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because LRCK of TDM use High to Low as default setting, this patch
changes the TDM setting to inverse LRCK.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index f1c58a2..2b5df2e 100644
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
1.7.9.5
