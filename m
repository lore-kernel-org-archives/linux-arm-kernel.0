From: adanhawthorn@gmail.com (Nathan Howard)
Date: Thu, 16 Feb 2017 18:12:58 -0500
Subject: [PATCH] staging: bcm2835-audio: bcm2835.h: fix various coding style
 issues
Message-ID: <1487286834-7490-1-git-send-email-adanhawthorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix various coding style issues as per checkpatch.pl.

Signed-off-by: Nathan Howard <adanhawthorn@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.h | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
index 36e3ef8..16d7006 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/bcm2835-audio/bcm2835.h
@@ -27,8 +27,8 @@
 #include <linux/workqueue.h>
 
 /*
-#define AUDIO_DEBUG_ENABLE
-#define AUDIO_VERBOSE_DEBUG_ENABLE
+ * #define AUDIO_DEBUG_ENABLE
+ * #define AUDIO_VERBOSE_DEBUG_ENABLE
  */
 
 /* Debug macros */
@@ -37,10 +37,10 @@
 #ifdef AUDIO_VERBOSE_DEBUG_ENABLE
 
 #define audio_debug(fmt, arg...) \
-	printk(KERN_INFO"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_info("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define audio_info(fmt, arg...) \
-	printk(KERN_INFO"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_info("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #else
 
@@ -59,13 +59,13 @@
 #endif /* AUDIO_DEBUG_ENABLE */
 
 #define audio_error(fmt, arg...) \
-	printk(KERN_ERR"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_err("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define audio_warning(fmt, arg...) \
-	printk(KERN_WARNING"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_warn("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define audio_alert(fmt, arg...) \
-	printk(KERN_ALERT"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_alert("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
@@ -77,8 +77,11 @@ enum {
 
 /* macros for alsa2chip and chip2alsa, instead of functions */
 
-#define alsa2chip(vol) (uint)(-((vol << 8) / 100)) /* convert alsa to chip volume (defined as macro rather than function call) */
-#define chip2alsa(vol) -((vol * 100) >> 8)   /* convert chip to alsa volume */
+// convert alsa to chip volume (defined as macro rather than function call)
+#define alsa2chip(vol) (uint)(-(((vol) << 8) / 100))
+
+// convert chip to alsa volume
+#define chip2alsa(vol) -(((vol) * 100) >> 8)
 
 /* Some constants for values .. */
 enum snd_bcm2835_route {
@@ -122,8 +125,8 @@ struct bcm2835_alsa_stream {
 	struct semaphore buffers_update_sem;
 	struct semaphore control_sem;
 	spinlock_t lock;
-	volatile unsigned int control;
-	volatile unsigned int status;
+	unsigned int control;
+	unsigned int status;
 
 	int open;
 	int running;
@@ -160,8 +163,10 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			unsigned int count,
 			void *src);
 void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream);
-unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream);
+unsigned int bcm2835_audio_retrieve_buffers(
+		struct bcm2835_alsa_stream *alsa_stream);
 void bcm2835_audio_flush_buffers(struct bcm2835_alsa_stream *alsa_stream);
-void bcm2835_audio_flush_playback_buffers(struct bcm2835_alsa_stream *alsa_stream);
+void bcm2835_audio_flush_playback_buffers(
+		struct bcm2835_alsa_stream *alsa_stream);
 
 #endif /* __SOUND_ARM_BCM2835_H */
-- 
2.7.4
