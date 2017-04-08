From: sfaragnaus@gmail.com (Andrea della Porta)
Date: Sat, 8 Apr 2017 17:22:05 +0100
Subject: [PATCH v2 2/3] staging: vc04_services: bcm2835-audio: bcm2835-pcm.c
 Fixed codepatch coding style issue, line over 80
In-Reply-To: <cover.1491666884.git.sfaragnaus@gmail.com>
References: <cover.1491666884.git.sfaragnaus@gmail.com>
Message-ID: <00913da6c1873cf84ce06791a7427d3dc723ecda.1491666884.git.sfaragnaus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed checkpatch warning about line over 80 chars

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
Changes in v2:
- subject line more explicit
- chekpatch output removed as requested, summarized in one line

 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index fa6d3d2..f1ce5cf 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -539,7 +539,8 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	/* NOTE: this may fail */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 					      snd_dma_continuous_data(GFP_KERNEL),
-					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
+					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max, 
+					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
 out:
 	mutex_unlock(&chip->audio_mutex);
 	audio_info(" .. OUT\n");
-- 
2.4.10
