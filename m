From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 14:30:20 +0200
Subject: [PATCH] usb: gadget: uvc: fix up uvcg_v4l2_get_unmapped_area typo
Message-ID: <3777003.OnaxFdNv7R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch "usb: gadget: uvc: rename functions to avoid conflicts with host uvc"
renamed a lot of symbols but missed one references that was inside of
an #ifdef:

drivers/usb/gadget/function/uvc_v4l2.c:363:23: error: 'uvcg_v4l2_get_unmapped_area' undeclared here (not in a function)
  .get_unmapped_area = uvcg_v4l2_get_unmapped_area,
                       ^
drivers/usb/gadget/function/uvc_v4l2.c:344:22: warning: 'uvc_v4l2_get_unmapped_area' defined but not used [-Wunused-function]
 static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
                      ^

This renames the reference according the changed function name.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7ea95b110811 ("usb: gadget: uvc: rename functions to avoid conflicts with host uvc")
Cc: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb at vger.kernel.org
---
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index b52f2681ec21..5aad7fededa5 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -341,7 +341,7 @@ uvc_v4l2_poll(struct file *file, poll_table *wait)
 }
 
 #ifndef CONFIG_MMU
-static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
+static unsigned long uvcg_v4l2_get_unmapped_area(struct file *file,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
 		unsigned long flags)
 {
