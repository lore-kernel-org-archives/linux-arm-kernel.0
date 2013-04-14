From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:50 +0200
Subject: [PATCH v3 06/15] ASoC: imx-pcm-dma: DT support
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutrnoix.de>

This patch adds the possibility to pass a of_node as platform_data which
is used by generic-pcm-dma to request a DMA slave channel.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-pcm-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 9eb0021..a6cdae7 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -62,9 +62,11 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
 
 int imx_pcm_dma_init(struct platform_device *pdev)
 {
+	if (pdev->dev.platform_data)
+		pdev->dev.of_node = pdev->dev.platform_data;
+
 	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
-		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
-- 
1.8.1.5
