From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 Oct 2018 17:29:27 +0200
Subject: [PATCH RFC 03/11] staging: bcm2835-camera: Move module info to the end
In-Reply-To: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540481375-15952-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to have this more consistent between the vc04 services move
the module information to the end of the file.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 7d3222c..cd773eb 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -43,12 +43,6 @@
 
 #define MAX_BCM2835_CAMERAS 2
 
-MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
-MODULE_AUTHOR("Vincent Sanders");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(BM2835_MMAL_VERSION);
-MODULE_ALIAS("platform:bcm2835-camera");
-
 int bcm2835_v4l2_debug;
 module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
 MODULE_PARM_DESC(bcm2835_v4l2_debug, "Debug level 0-2");
@@ -1976,3 +1970,9 @@ static struct platform_driver bcm2835_camera_driver = {
 };
 
 module_platform_driver(bcm2835_camera_driver)
+
+MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
+MODULE_AUTHOR("Vincent Sanders");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(BM2835_MMAL_VERSION);
+MODULE_ALIAS("platform:bcm2835-camera");
-- 
2.7.4
