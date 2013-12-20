From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 19 Dec 2013 22:20:48 -0300
Subject: [PATCH] usb: musb: Remove USB_GADGET driver dependency
Message-ID: <1387502448-11041-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This USB controller is dual-role, but can also work in host-only mode.
There's no reason to condition the entire driver to USB_GADGET. Fix this by
removing the dependency.

Tested on a Beaglebone black (AM335x) using a regular USB mass storage
device.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/usb/musb/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 57dfc0c..2119370 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -6,7 +6,6 @@
 # (M)HDRC = (Multipoint) Highspeed Dual-Role Controller
 config USB_MUSB_HDRC
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
-	depends on USB_GADGET
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on the Mentor Graphics silicon IP.  Then
-- 
1.8.1.5
