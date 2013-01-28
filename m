From: rogerq@ti.com (Roger Quadros)
Date: Mon, 28 Jan 2013 13:30:31 +0200
Subject: [PATCH 30/30] ARM: OMAP: USB: Remove unused fields from struct
 usbhs_omap_platform_data
In-Reply-To: <1359372631-8180-1-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
Message-ID: <1359372631-8180-31-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All users have been adapted to the changes in ehci-omap. We can now
get rid of the unused fields from usbhs_omap_platform_data.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/platform_data/usb-omap.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index 925a4a7..227601f 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -41,13 +41,10 @@ enum usbhs_omap_port_mode {
 struct usbhs_omap_platform_data {
 	int				nports;
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
-	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 
 	/* OMAP3 <= ES2.1 have a single ulpi bypass control bit */
 	unsigned			single_ulpi_bypass:1;
 	unsigned			es2_compatibility:1;
-	unsigned			phy_reset:1;
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.7.4.1
