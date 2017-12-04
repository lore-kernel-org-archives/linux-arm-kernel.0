From: sky@genki.is (Genki Sky)
Date: Mon, 04 Dec 2017 01:17:36 -0500
Subject: [PATCH] staging: vc04_services: Fix trivial style issues
Message-ID: <30cc7b48def470f1bec8d8d255044f4f220531ee.1512368114.git.sky@genki.is>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In bcm2835-camera, handle the following checkpatch.pl types:
  - EMBEDDED_FUNCTION_NAME
  - MULTILINE_DEREFERENCE
  - SPLIT_STRING

[ note: this is for Task 10 of http://eudyptula-challenge.org/ ]

Signed-off-by: Genki Sky <sky@genki.is>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 23 +++++++++-------------
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  7 +++----
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d8766b166675..e26895dc052e 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -328,11 +328,9 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 				pr_debug("Grab another frame");
 				vchiq_mmal_port_parameter_set(
 					instance,
-					dev->capture.
-					camera_port,
+					dev->capture.camera_port,
 					MMAL_PARAMETER_CAPTURE,
-					&dev->capture.
-					frame_count,
+					&dev->capture.frame_count,
 					sizeof(dev->capture.frame_count));
 			}
 		} else {
@@ -349,8 +347,7 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 				timestamp = ktime_add_us(dev->capture.kernel_start_ts,
 							 runtime_us);
 				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
-					 "Convert start time %llu and %llu "
-					 "with offset %llu to %llu\n",
+					 "Convert start time %llu and %llu with offset %llu to %llu\n",
 					 ktime_to_ns(dev->capture.kernel_start_ts),
 					 dev->capture.vc_start_timestamp, pts,
 					 ktime_to_ns(timestamp));
@@ -368,11 +365,9 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 					 "Grab another frame as buffer has EOS");
 				vchiq_mmal_port_parameter_set(
 					instance,
-					dev->capture.
-					camera_port,
+					dev->capture.camera_port,
 					MMAL_PARAMETER_CAPTURE,
-					&dev->capture.
-					frame_count,
+					&dev->capture.frame_count,
 					sizeof(dev->capture.frame_count));
 			}
 		} else {
@@ -536,8 +531,8 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 	    vchiq_mmal_port_enable(dev->instance, dev->capture.port, buffer_cb);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev,
-			"Failed to enable capture port - error %d. "
-			"Disabling camera port again\n", ret);
+			"Failed to enable capture port - error %d. Disabling camera port again\n",
+			ret);

 		vchiq_mmal_port_disable(dev->instance,
 					dev->capture.camera_port);
@@ -1194,8 +1189,8 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 					port->current_buffer.size =
 					    (f->fmt.pix.sizeimage <
 					     (100 << 10))
-					    ? (100 << 10) : f->fmt.pix.
-					    sizeimage;
+					    ? (100 << 10)
+					    : f->fmt.pix.sizeimage;
 				}
 				v4l2_dbg(1, bcm2835_v4l2_debug,
 					 &dev->v4l2_dev,
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 6ea7fb0ea50e..6c4d8b4c7cd9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -618,8 +618,8 @@ static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 	struct mmal_msg_context *msg_context;
 	u32 handle;

-	pr_debug("buffer_to_host_cb: instance:%p msg:%p msg_len:%d\n",
-		 instance, msg, msg_len);
+	pr_debug("%s: instance:%p msg:%p msg_len:%d\n",
+		 __func__, instance, msg, msg_len);

 	if (msg->u.buffer_from_host.drvbuf.magic == MMAL_MAGIC) {
 		handle = msg->u.buffer_from_host.drvbuf.client_context;
@@ -1360,8 +1360,7 @@ static int port_action_handle(struct vchiq_mmal_instance *instance,

 	ret = -rmsg->u.port_action_reply.status;

-	pr_debug("%s:result:%d component:0x%x port:%d action:%s(%d)" \
-		 " connect component:0x%x connect port:%d\n",
+	pr_debug("%s:result:%d component:0x%x port:%d action:%s(%d) connect component:0x%x connect port:%d\n",
 		 __func__,
 		 ret, port->component->handle, port->handle,
 		 port_action_type_names[action_type],
--
2.15.1
