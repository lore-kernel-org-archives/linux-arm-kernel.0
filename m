From: sky@genki.is (Genki Sky)
Date: Tue, 05 Dec 2017 19:09:54 -0500
Subject: [PATCH v3 2/3] staging: vc04_services: Unsplit user-visible strings
In-Reply-To: <cover.1512518762.git.sky@genki.is>
References: <cover.1512518762.git.sky@genki.is>
Message-ID: <286081ca72745c168ed07fc17f56d2e06fe76569.1512518762.git.sky@genki.is>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was found using checkpatch.pl's SPLIT_STRING warning. While joining
these strings makes for long lines, the kernel codebase consistently
does it this way to make user-visible strings easier to grep for.

Signed-off-by: Genki Sky <sky@genki.is>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 7 +++----
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c     | 3 +--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 4ed3b449f97f..e26895dc052e 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -347,8 +347,7 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 				timestamp = ktime_add_us(dev->capture.kernel_start_ts,
 							 runtime_us);
 				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
-					 "Convert start time %llu and %llu "
-					 "with offset %llu to %llu\n",
+					 "Convert start time %llu and %llu with offset %llu to %llu\n",
 					 ktime_to_ns(dev->capture.kernel_start_ts),
 					 dev->capture.vc_start_timestamp, pts,
 					 ktime_to_ns(timestamp));
@@ -532,8 +531,8 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 	    vchiq_mmal_port_enable(dev->instance, dev->capture.port, buffer_cb);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev,
-			"Failed to enable capture port - error %d. "
-			"Disabling camera port again\n", ret);
+			"Failed to enable capture port - error %d. Disabling camera port again\n",
+			ret);
 
 		vchiq_mmal_port_disable(dev->instance,
 					dev->capture.camera_port);
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 6ea7fb0ea50e..5ddea4f54bf7 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
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
