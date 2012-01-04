From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Wed, 4 Jan 2012 12:47:48 +0530
Subject: [PATCH v8 1/2] davinci: vpif: remove machine specific header file
 inclusion from the driver
In-Reply-To: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
References: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1325661469-4411-2-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove unnecessary inclusion of machine specific header files mach/dm646x.h,
mach/hardware.h from vpif.h  and aslo mach/dm646x.h from vpif_display.c
driver which comes in the way of platform code consolidation.
Add linux/i2c.h header file in vpif_types.h which is required for
building.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: LMML <linux-media@vger.kernel.org>
---
 drivers/media/video/davinci/vpif.h         |    2 --
 drivers/media/video/davinci/vpif_display.c |    2 --
 include/media/davinci/vpif_types.h         |    2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/davinci/vpif.h b/drivers/media/video/davinci/vpif.h
index 25036cb..8bcac65 100644
--- a/drivers/media/video/davinci/vpif.h
+++ b/drivers/media/video/davinci/vpif.h
@@ -18,8 +18,6 @@
 
 #include <linux/io.h>
 #include <linux/videodev2.h>
-#include <mach/hardware.h>
-#include <mach/dm646x.h>
 #include <media/davinci/vpif_types.h>
 
 /* Maximum channel allowed */
diff --git a/drivers/media/video/davinci/vpif_display.c b/drivers/media/video/davinci/vpif_display.c
index 286f029..7fa34b4 100644
--- a/drivers/media/video/davinci/vpif_display.c
+++ b/drivers/media/video/davinci/vpif_display.c
@@ -39,8 +39,6 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-chip-ident.h>
 
-#include <mach/dm646x.h>
-
 #include "vpif_display.h"
 #include "vpif.h"
 
diff --git a/include/media/davinci/vpif_types.h b/include/media/davinci/vpif_types.h
index 9929b05..bd8217c 100644
--- a/include/media/davinci/vpif_types.h
+++ b/include/media/davinci/vpif_types.h
@@ -17,6 +17,8 @@
 #ifndef _VPIF_TYPES_H
 #define _VPIF_TYPES_H
 
+#include <linux/i2c.h>
+
 #define VPIF_CAPTURE_MAX_CHANNELS	2
 
 enum vpif_if_type {
-- 
1.6.2.4
