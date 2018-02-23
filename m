From: colin.king@canonical.com (Colin King)
Date: Fri, 23 Feb 2018 14:37:38 +0000
Subject: [PATCH] ASoC: pxa: remove duplicated bit-wise or of
 SNDRV_PCM_FMTBIT_S24_LE
Message-ID: <20180223143738.29600-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Bit pattern SNDRV_PCM_FMTBIT_S24_LE is being bit-wise or'd twice; remove
the redundant 2nd SNDRV_PCM_FMTBIT_S24_LE

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.15.1
