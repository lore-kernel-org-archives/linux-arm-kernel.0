From: robsonde@gmail.com (Derek Robson)
Date: Sun, 26 Feb 2017 14:02:32 +1300
Subject: [PATCH] Staging: bcm2835-audio - style fix, block comments
Message-ID: <20170226010232.21108-1-robsonde@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed block comments as found by checkpatch

Signed-off-by: Derek Robson <robsonde@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-ctl.c | 3 ++-
 drivers/staging/bcm2835-audio/bcm2835-pcm.c | 3 ++-
 drivers/staging/bcm2835-audio/bcm2835.h     | 5 -----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
index a4ffa1bf53e5..1dd68c116f57 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
@@ -248,7 +248,8 @@ static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
 {
 	/* bcm2835 supports only consumer mode and sets all other format flags
 	 * automatically. So the only thing left is signalling non-audio
-	 * content */
+	 * content
+	 */
 	ucontrol->value.iec958.status[0] = IEC958_AES0_NONAUDIO;
 	return 0;
 }
diff --git a/drivers/staging/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
index 16127e062661..d965e61b8a6a 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
@@ -308,7 +308,8 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 
 	/* notify the vchiq that it should enter spdif passthrough mode by
 	 * setting channels=0 (see
-	 * https://github.com/raspberrypi/linux/issues/528) */
+	 * https://github.com/raspberrypi/linux/issues/528)
+	 */
 	if (chip->spdif_status & IEC958_AES0_NONAUDIO)
 		channels = 0;
 	else
diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
index 36e3ef80e60c..292cf1dc4d7a 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/bcm2835-audio/bcm2835.h
@@ -26,11 +26,6 @@
 #include <sound/pcm-indirect.h>
 #include <linux/workqueue.h>
 
-/*
-#define AUDIO_DEBUG_ENABLE
-#define AUDIO_VERBOSE_DEBUG_ENABLE
- */
-
 /* Debug macros */
 
 #ifdef AUDIO_DEBUG_ENABLE
-- 
2.11.1
