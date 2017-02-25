From: flatmax@flatmax.org (Matt Flax)
Date: Sat, 25 Feb 2017 16:03:13 +1100
Subject: [PATCH 2/3] ASoC: cs42xx8: allow IC master mode.
In-Reply-To: <cover.1487997974.git.flatmax@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
Message-ID: <851a0a9ff20c077fc2d6ff84c1824ba462ce19ca.1487997974.git.flatmax@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the cs42xx8 to be put into slave mode when an IC
(between this codec and the SoC) is master.

It sets slave mode by treating SND_SOC_DAIFMT_IBM_IFM in the same way
it treats SND_SOC_DAIFMT_CBS_CFS.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/codecs/cs42xx8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index c1785bd..34f9adb 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -235,6 +235,7 @@ static int cs42xx8_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	/* Set master/slave audio interface */
 	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_IBM_IFM:
 		cs42xx8->slave_mode = true;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-- 
2.7.4
