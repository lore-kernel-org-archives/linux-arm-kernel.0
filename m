From: abhijitnaik27@gmail.com (Abhijit Naik)
Date: Tue, 14 Feb 2017 00:42:17 +0530
Subject: [PATCH 2/2] staging: bcm2835-audio: Fixed checkpatch warning due to
 line spacing
In-Reply-To: <20170213191217.5201-1-abhijitnaik27@gmail.com>
References: <20170213191217.5201-1-abhijitnaik27@gmail.com>
Message-ID: <20170213191217.5201-2-abhijitnaik27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835-vchiq.c:
fixing ERROR: Checkpatch warnings due to extra blank lines or absence of blank
lines where needed.

Signed-off-by: Abhijit Naik <abhijitnaik27@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index d11f2cdd1014..af0cd0b36bc5 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -78,7 +78,6 @@ static int bcm2835_audio_start_worker(struct bcm2835_alsa_stream *alsa_stream);
 static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
 				      unsigned int count, void *src);

-
 // Routine to send a message across a service

 static int
@@ -109,6 +108,7 @@ static void my_wq_function(struct work_struct *work)
 	struct bcm2835_audio_work *w =
 		container_of(work, struct bcm2835_audio_work, my_work);
 	int ret = -9;
+
 	LOG_DBG(" .. IN %p:%d\n", w->alsa_stream, w->cmd);
 	switch (w->cmd) {
 	case BCM2835_AUDIO_START:
@@ -132,6 +132,7 @@ static void my_wq_function(struct work_struct *work)
 int bcm2835_audio_start(struct bcm2835_alsa_stream *alsa_stream)
 {
 	int ret = -1;
+
 	LOG_DBG(" .. IN\n");
 	if (alsa_stream->my_wq) {
 		struct bcm2835_audio_work *work =
@@ -153,6 +154,7 @@ int bcm2835_audio_start(struct bcm2835_alsa_stream *alsa_stream)
 int bcm2835_audio_stop(struct bcm2835_alsa_stream *alsa_stream)
 {
 	int ret = -1;
+
 	LOG_DBG(" .. IN\n");
 	if (alsa_stream->my_wq) {
 		struct bcm2835_audio_work *work =
@@ -175,6 +177,7 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			unsigned int count, void *src)
 {
 	int ret = -1;
+
 	LOG_DBG(" .. IN\n");
 	if (alsa_stream->my_wq) {
 		struct bcm2835_audio_work *work =
@@ -219,6 +222,7 @@ static void audio_vchi_callback(void *param,
 	int status;
 	int msg_len;
 	struct vc_audio_msg m;
+
 	LOG_DBG(" .. IN instance=%p, handle=%p, alsa=%p, reason=%d, handle=%p\n",
 		instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);

@@ -244,6 +248,7 @@ static void audio_vchi_callback(void *param,
 		complete(&instance->msg_avail_comp);
 	} else if (m.type == VC_AUDIO_MSG_TYPE_COMPLETE) {
 		struct bcm2835_alsa_stream *alsa_stream = instance->alsa_stream;
+
 		LOG_DBG(" .. instance=%p, m.type=VC_AUDIO_MSG_TYPE_COMPLETE, complete=%d\n",
 			instance, m.u.complete.count);
 		if (m.u.complete.cookie1 != BCM2835_AUDIO_WRITE_COOKIE1 ||
@@ -357,6 +362,7 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
 	/* Close all VCHI service connections */
 	for (i = 0; i < instance->num_connections; i++) {
 		int status;
+
 		LOG_DBG(" .. %i:closing %p\n", i, instance->vchi_handle[i]);
 		vchi_service_use(instance->vchi_handle[i]);

@@ -384,6 +390,7 @@ static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream
 	struct bcm2835_audio_instance *instance =
 		(struct bcm2835_audio_instance *)alsa_stream->instance;
 	int ret;
+
 	LOG_DBG(" .. IN\n");

 	LOG_INFO("%s: start\n", __func__);
@@ -445,6 +452,7 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 	struct vc_audio_msg m;
 	int status;
 	int ret;
+
 	LOG_DBG(" .. IN\n");

 	my_workqueue_init(alsa_stream);
@@ -494,6 +502,7 @@ static int bcm2835_audio_set_ctls_chan(struct bcm2835_alsa_stream *alsa_stream,
 	struct bcm2835_audio_instance *instance = alsa_stream->instance;
 	int status;
 	int ret;
+
 	LOG_DBG(" .. IN\n");

 	LOG_INFO(" Setting ALSA dest(%d), volume(%d)\n",
@@ -551,6 +560,7 @@ int bcm2835_audio_set_ctls(struct bcm2835_chip *chip)
 {
 	int i;
 	int ret = 0;
+
 	LOG_DBG(" .. IN\n");
 	LOG_DBG(" Setting ALSA dest(%d), volume(%d)\n", chip->dest, chip->volume);

@@ -580,6 +590,7 @@ int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
 	struct bcm2835_audio_instance *instance = alsa_stream->instance;
 	int status;
 	int ret;
+
 	LOG_DBG(" .. IN\n");

 	LOG_INFO(" Setting ALSA channels(%d), samplerate(%d), bits-per-sample(%d)\n",
@@ -655,6 +666,7 @@ static int bcm2835_audio_start_worker(struct bcm2835_alsa_stream *alsa_stream)
 	struct bcm2835_audio_instance *instance = alsa_stream->instance;
 	int status;
 	int ret;
+
 	LOG_DBG(" .. IN\n");

 	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
@@ -693,6 +705,7 @@ static int bcm2835_audio_stop_worker(struct bcm2835_alsa_stream *alsa_stream)
 	struct bcm2835_audio_instance *instance = alsa_stream->instance;
 	int status;
 	int ret;
+
 	LOG_DBG(" .. IN\n");

 	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
@@ -732,6 +745,7 @@ int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream)
 	struct bcm2835_audio_instance *instance = alsa_stream->instance;
 	int status;
 	int ret;
+
 	LOG_DBG(" .. IN\n");

 	my_workqueue_quit(alsa_stream);
@@ -839,6 +853,7 @@ static int bcm2835_audio_write_worker(struct bcm2835_alsa_stream *alsa_stream,
 		} else {
 			while (count > 0) {
 				int bytes = min((int) m.u.write.max_packet, (int) count);
+
 				status = bcm2835_vchi_msg_queue(instance->vchi_handle[0],
 								src, bytes);
 				src = (char *)src + bytes;
@@ -885,6 +900,7 @@ void bcm2835_audio_flush_playback_buffers(struct bcm2835_alsa_stream *alsa_strea
 unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream)
 {
 	unsigned int count = atomic_read(&alsa_stream->retrieved);
+
 	atomic_sub(count, &alsa_stream->retrieved);
 	return count;
 }
--
2.11.0
