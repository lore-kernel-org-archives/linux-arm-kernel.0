From: abhijitnaik27@gmail.com (Abhijit Naik)
Date: Thu, 23 Feb 2017 18:30:59 +0530
Subject: [PATCH 1/2] staging: bcm2835-audi: Removed return statement from void
 functions
Message-ID: <20170223130100.6278-1-abhijitnaik27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835-vchiq.c:
fixing WARNING: void function return statements are not generally useful

Signed-off-by: Abhijit Naik <abhijitnaik27@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index fa23a13f8d95..1a6b4382c15b 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -204,7 +204,6 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 static void my_workqueue_init(struct bcm2835_alsa_stream *alsa_stream)
 {
 	alsa_stream->my_wq = alloc_workqueue("my_queue", WQ_HIGHPRI, 1);
-	return;
 }
 
 static void my_workqueue_quit(struct bcm2835_alsa_stream *alsa_stream)
@@ -214,7 +213,6 @@ static void my_workqueue_quit(struct bcm2835_alsa_stream *alsa_stream)
 		destroy_workqueue(alsa_stream->my_wq);
 		alsa_stream->my_wq = NULL;
 	}
-	return;
 }
 
 static void audio_vchi_callback(void *param,
@@ -887,7 +885,6 @@ void bcm2835_audio_flush_buffers(struct bcm2835_alsa_stream *alsa_stream)
 {
 	LOG_DBG(" .. IN\n");
 	LOG_DBG(" .. OUT\n");
-	return;
 }
 
 /**
-- 
2.11.0
