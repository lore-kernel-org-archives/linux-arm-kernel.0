From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 13 Jul 2017 00:52:23 -0500
Subject: [PATCH] ASoC: sun8i-codec: constify snd_soc_dai_ops structure
Message-ID: <20170713055223.GA18940@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 5723c34..253ae0b 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -341,7 +341,7 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	  "AIF1 Slot 0 Right"},
 };
 
-static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
+static const struct snd_soc_dai_ops sun8i_codec_dai_ops = {
 	.hw_params = sun8i_codec_hw_params,
 	.set_fmt = sun8i_set_fmt,
 };
-- 
2.5.0
