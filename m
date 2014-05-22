From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu, 22 May 2014 22:21:00 +0200
Subject: [PATCH] sound: soc: samsung: dma.c: Fix to remove null pointer checks
 that could never happen
Message-ID: <1400790060-10977-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removal of null pointer checks that could never happen

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/soc/samsung/dma.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index dc09b71..0f17ae0 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -124,8 +124,7 @@ static void audio_buffdone(void *data)
 		if (prtd->dma_pos >= prtd->dma_end)
 			prtd->dma_pos = prtd->dma_start;
 
-		if (substream)
-			snd_pcm_period_elapsed(substream);
+		snd_pcm_period_elapsed(substream);
 
 		spin_lock(&prtd->lock);
 		if (!samsung_dma_has_circular()) {
-- 
1.7.10.4
