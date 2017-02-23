From: abhijitnaik27@gmail.com (Abhijit Naik)
Date: Thu, 23 Feb 2017 18:31:00 +0530
Subject: [PATCH 2/2] staging: bcm2835-audio: Removed braces of single
 statement blocks
In-Reply-To: <20170223130100.6278-1-abhijitnaik27@gmail.com>
References: <20170223130100.6278-1-abhijitnaik27@gmail.com>
Message-ID: <20170223130100.6278-2-abhijitnaik27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835-vchiq.c:
fixing WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Abhijit Naik <abhijitnaik27@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index 1a6b4382c15b..df1f3dd9e226 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -227,9 +227,9 @@ static void audio_vchi_callback(void *param,
 	LOG_DBG(" .. IN instance=%p, handle=%p, alsa=%p, reason=%d, handle=%p\n",
 		instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
 
-	if (reason != VCHI_CALLBACK_MSG_AVAILABLE) {
+	if (reason != VCHI_CALLBACK_MSG_AVAILABLE)
 		return;
-	}
+
 	if (!instance) {
 		LOG_ERR(" .. instance is null\n");
 		BUG();
@@ -818,9 +818,10 @@ static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
 	}
 	vchi_service_use(instance->vchi_handle[0]);
 
-	if (instance->peer_version == 0 && vchi_get_peer_version(instance->vchi_handle[0], &instance->peer_version) == 0) {
+	if (instance->peer_version == 0 &&
+			vchi_get_peer_version(instance->vchi_handle[0], &instance->peer_version) == 0)
 		LOG_DBG("%s: client version %d connected\n", __func__, instance->peer_version);
-	}
+
 	m.type = VC_AUDIO_MSG_TYPE_WRITE;
 	m.u.write.count = count;
 	// old version uses bulk, new version uses control
-- 
2.11.0
