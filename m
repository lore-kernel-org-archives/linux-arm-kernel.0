From: sky@genki.is (Genki Sky)
Date: Tue, 05 Dec 2017 19:09:54 -0500
Subject: [PATCH v3 1/3] staging: vc04_services: Join multiline dereferences
In-Reply-To: <cover.1512518762.git.sky@genki.is>
References: <cover.1512518762.git.sky@genki.is>
Message-ID: <a4c94477e1d45c59e7325da7b6fc8a414eb32766.1512518762.git.sky@genki.is>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was found using checkpatch.pl's MULTILINE_DEREFERENCE warning.
Putting the dereference onto one line makes them easier to read,
especially when part of a larger expression (in this case, function
arguments and ternary operator), and when the dereferences are short
(as they are here).

Signed-off-by: Genki Sky <sky@genki.is>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c        | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d8766b166675..4ed3b449f97f 100644
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
@@ -368,11 +366,9 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
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
@@ -1194,8 +1190,8 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
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
-- 
2.15.1
