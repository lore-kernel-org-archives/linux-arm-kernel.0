From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 13 Jul 2017 01:05:08 -0500
Subject: [PATCH] ASoC: mmp-sspa: constify snd_soc_dai_ops structure
Message-ID: <20170713060508.GA22657@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/pxa/mmp-sspa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 9cc3501..64b85e3 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -380,7 +380,7 @@ static int mmp_sspa_probe(struct snd_soc_dai *dai)
 		SNDRV_PCM_FMTBIT_S24_LE | \
 		SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops mmp_sspa_dai_ops = {
+static const struct snd_soc_dai_ops mmp_sspa_dai_ops = {
 	.startup	= mmp_sspa_startup,
 	.shutdown	= mmp_sspa_shutdown,
 	.trigger	= mmp_sspa_trigger,
-- 
2.5.0
