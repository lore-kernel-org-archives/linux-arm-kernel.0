From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 Oct 2018 17:29:26 +0200
Subject: [PATCH RFC 02/11] staging: bcm2835-camera: fix module autoloading
In-Reply-To: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540481375-15952-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make the module bcm2835-camera load automatically, we need to
add a module alias.

Fixes: 4bebb0312ea9 ("staging/bcm2835-camera: Set ourselves up as a platform driver.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d6fbef7..7d3222c 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -47,6 +47,7 @@ MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(BM2835_MMAL_VERSION);
+MODULE_ALIAS("platform:bcm2835-camera");
 
 int bcm2835_v4l2_debug;
 module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
-- 
2.7.4
