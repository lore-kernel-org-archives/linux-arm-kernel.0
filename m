From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Tue,  5 Jul 2016 11:46:29 +0200
Subject: [PATCH] ASoC: atmel_ssc_dai: Fix DMA params for different SSC
Message-ID: <20160705094629.5326-1-pmeerw@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

follow-up patch from c706f2e55f ASoC: atmel_ssc_dai: distinguish the
different SSC

cpu_dai id is always 0, use platform_device id to distinguish DMA
parameters of SSCs

Signed-off-by: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>
Cc: "Wu, Songjun" <songjun.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 841d059..c7daea8 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -320,7 +320,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	dma_params = &ssc_dma_params[dai->id][dir];
+	dma_params = &ssc_dma_params[pdev->id][dir];
 	dma_params->ssc = ssc_p->ssc;
 	dma_params->substream = substream;
 
-- 
2.9.0
