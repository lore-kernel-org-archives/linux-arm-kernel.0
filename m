From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:23 +0200
Subject: [PATCH/RFT v2 06/17] ARM: davinci: da8xx: Fix some redefined symbol
 warnings
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <20161024164634.4330-7-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Bailon <abailon@baylibre.com>

Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
but da8xx-cfgchip.h intend to replace them.
The usb-da8xx.c is using both headers, causing redefined symbol warnings.
Remove the old macros.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 include/linux/platform_data/usb-davinci.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index e0bc4ab..0926e99 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,29 +11,6 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-/* DA8xx CFGCHIP2 (USB 2.0 PHY Control) register bits */
-#define CFGCHIP2_PHYCLKGD	(1 << 17)
-#define CFGCHIP2_VBUSSENSE	(1 << 16)
-#define CFGCHIP2_RESET		(1 << 15)
-#define CFGCHIP2_OTGMODE	(3 << 13)
-#define CFGCHIP2_NO_OVERRIDE	(0 << 13)
-#define CFGCHIP2_FORCE_HOST	(1 << 13)
-#define CFGCHIP2_FORCE_DEVICE 	(2 << 13)
-#define CFGCHIP2_FORCE_HOST_VBUS_LOW (3 << 13)
-#define CFGCHIP2_USB1PHYCLKMUX	(1 << 12)
-#define CFGCHIP2_USB2PHYCLKMUX	(1 << 11)
-#define CFGCHIP2_PHYPWRDN	(1 << 10)
-#define CFGCHIP2_OTGPWRDN	(1 << 9)
-#define CFGCHIP2_DATPOL 	(1 << 8)
-#define CFGCHIP2_USB1SUSPENDM	(1 << 7)
-#define CFGCHIP2_PHY_PLLON	(1 << 6)	/* override PLL suspend */
-#define CFGCHIP2_SESENDEN	(1 << 5)	/* Vsess_end comparator */
-#define CFGCHIP2_VBDTCTEN	(1 << 4)	/* Vbus comparator */
-#define CFGCHIP2_REFFREQ	(0xf << 0)
-#define CFGCHIP2_REFFREQ_12MHZ	(1 << 0)
-#define CFGCHIP2_REFFREQ_24MHZ	(2 << 0)
-#define CFGCHIP2_REFFREQ_48MHZ	(3 << 0)
-
 struct	da8xx_ohci_root_hub;
 
 typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
-- 
1.9.1
