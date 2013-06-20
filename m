From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 15:20:20 +0200
Subject: [PATCH v9 01/10] ASoC: imx-pcm-dma: DT support
In-Reply-To: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the NO_DT flag. The pdev pointer may have a proper
of_node with the dmas property, so we can use it to request DMA
channels.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---

Notes:
    Changes in v6:
     - After rebasing onto Shawn's imx-pcm cleanups, this patch just consists of
       removing the NO_DT flag.
    
    Changes in v5:
     - Use dev.parent pointer to get the of_node.

 sound/soc/fsl/imx-pcm-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index fde4d2e..f323ce0 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -64,7 +64,6 @@ int imx_pcm_dma_init(struct platform_device *pdev)
 {
 	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
-		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 EXPORT_SYMBOL_GPL(imx_pcm_dma_init);
-- 
1.8.2.1
