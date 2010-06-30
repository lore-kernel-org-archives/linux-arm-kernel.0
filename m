From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:00:23 +0200
Subject: [PATCH 20/33] Removing dead MACH_OMAP2_H4_USB1
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <24b01f2edebd09e37306c35f14401819d8219549.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_OMAP2_H4_USB1 doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-omap2/board-h4.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 85d7fb8..f0c2701 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -272,11 +272,6 @@ static struct omap_lcd_config h4_lcd_config __initdata = {
 };
 
 static struct omap_usb_config h4_usb_config __initdata = {
-#ifdef	CONFIG_MACH_OMAP2_H4_USB1
-	/* NOTE:  usb1 could also be used with 3 wire signaling */
-	.pins[1]	= 4,
-#endif
-
 	/* S1.10 OFF -- usb "download port"
 	 * usb0 switched to Mini-B port and isp1105 transceiver;
 	 * S2.POS3 = ON, S2.POS4 = OFF ... to enable battery charging
-- 
1.7.0.4
