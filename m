From: sfaragnaus@gmail.com (Andrea della Porta)
Date: Wed, 29 Mar 2017 06:15:36 +0100
Subject: [PATCH 2/3] fixed codepatch coding style issue, line over 80
In-Reply-To: <a7afd06fb8a7e36568e639020c07662692da2589.1490760735.git.sfaragnaus@gmail.com>
References: <cover.1490760735.git.sfaragnaus@gmail.com>
 <a7afd06fb8a7e36568e639020c07662692da2589.1490760735.git.sfaragnaus@gmail.com>
Message-ID: <d34e8125d5819066756e245e5759b39932afafa0.1490760735.git.sfaragnaus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed issue:
WARNING: line over 80 characters
#545: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:545:
+               snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
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
