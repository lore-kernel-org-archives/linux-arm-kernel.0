From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 15:49:13 +0100
Subject: [PATCH 1/2] ASoC: sun4i-spdif: remove legacy dapm components
In-Reply-To: <20161220144914.30945-1-codekipper@gmail.com>
References: <20161220144914.30945-1-codekipper@gmail.com>
Message-ID: <20161220144914.30945-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The dapm components are now handled by the ALSA SoC SPDIF DIT driver
so can be removed.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 88fbb3a1e660..048de15d6937 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -403,14 +403,6 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
-static const struct snd_soc_dapm_widget dit_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("spdif-out"),
-};
-
-static const struct snd_soc_dapm_route dit_routes[] = {
-	{ "spdif-out", NULL, "Playback" },
-};
-
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-spdif", },
 	{ .compatible = "allwinner,sun6i-a31-spdif", },
-- 
2.11.0
