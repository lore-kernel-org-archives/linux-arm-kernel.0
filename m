From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 19 Aug 2016 17:31:31 +0100
Subject: [PATCH] USB: ohci-omap - avoid including mach/irqs.h
Message-ID: <E1bamhf-0004XR-Nk@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ohci-omap doesn't need to include mach/irqs.h - nothing within this
driver needs anything from this header file.  Remove this include.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/usb/host/ohci-omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index de7c68602a7e..495c1454b9e8 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -36,7 +36,6 @@
 #include <mach/mux.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <mach/usb.h>
 
 
-- 
2.1.0
