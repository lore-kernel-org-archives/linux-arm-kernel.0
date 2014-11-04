From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  4 Nov 2014 10:55:05 +0100
Subject: [PATCH 10/15] [media] v4l: Forbid usage of V4L2_MBUS_FMT definitions
 inside the kernel
In-Reply-To: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415094910-15899-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place v4l2_mbus_pixelcode in a #ifndef __KERNEL__ section so that kernel
users don't have access to these definitions.

We have to keep this definition for user-space users even though they're
encouraged to move to the new media_bus_format enum.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/uapi/linux/v4l2-mediabus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/v4l2-mediabus.h b/include/uapi/linux/v4l2-mediabus.h
index 9fbe891..5a3e797 100644
--- a/include/uapi/linux/v4l2-mediabus.h
+++ b/include/uapi/linux/v4l2-mediabus.h
@@ -15,6 +15,7 @@
 #include <linux/videodev2.h>
 #include <linux/media-bus-format.h>
 
+#ifndef __KERNEL__
 #define MEDIA_BUS_TO_V4L2_MBUS(x)	V4L2_MBUS_FMT_ ## x = MEDIA_BUS_FMT_ ## x
 
 enum v4l2_mbus_pixelcode {
@@ -102,6 +103,7 @@ enum v4l2_mbus_pixelcode {
 
 	MEDIA_BUS_TO_V4L2_MBUS(AHSV8888_1X32),
 };
+#endif /* __KERNEL__ */
 
 /**
  * struct v4l2_mbus_framefmt - frame format on the media bus
-- 
1.9.1
