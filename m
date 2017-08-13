From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 13 Aug 2017 18:13:12 +0530
Subject: [PATCH 5/6] staging: bcm2835-audio:  make snd_pcm_hardware const
In-Reply-To: <1502628193-3343-1-git-send-email-bhumirks@gmail.com>
References: <1502628193-3343-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502628193-3343-6-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 1bf34ce..94654c0 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -20,7 +20,7 @@
 #include "bcm2835.h"
 
 /* hardware definition */
-static struct snd_pcm_hardware snd_bcm2835_playback_hw = {
+static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 	SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
@@ -36,7 +36,7 @@
 	.periods_max = 128,
 };
 
-static struct snd_pcm_hardware snd_bcm2835_playback_spdif_hw = {
+static const struct snd_pcm_hardware snd_bcm2835_playback_spdif_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 	SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-- 
1.9.1
