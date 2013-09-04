From: voice.shen@atmel.com (Bo Shen)
Date: Wed,  4 Sep 2013 15:27:46 +0800
Subject: [PATCH] ASoC: atmel: disable error interrupt
Message-ID: <1378279666-19873-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As once the error interrupt is triggered, it can not be cleared.
So, disable it.

No side effect found while testing on sama5d3xek and at91sam9x5ek
boards.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0ecf356..bb53dea 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -649,7 +649,7 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 	dma_params = ssc_p->dma_params[dir];
 
 	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
-	ssc_writel(ssc_p->ssc->regs, IER, dma_params->mask->ssc_error);
+	ssc_writel(ssc_p->ssc->regs, IDR, dma_params->mask->ssc_error);
 
 	pr_debug("%s enabled SSC_SR=0x%08x\n",
 			dir ? "receive" : "transmit",
-- 
1.7.9.5
