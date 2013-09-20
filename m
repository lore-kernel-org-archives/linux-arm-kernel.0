From: robertcnelson@gmail.com (robertcnelson)
Date: Fri, 20 Sep 2013 14:52:16 -0500
Subject: [PATCH] ARM: dts: omap3-beagle-xm: enable pullup for dvi on twl_gpio
Message-ID: <1379706736-4041-1-git-send-email-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Nelson <robertcnelson@gmail.com>

This fixes some video sync issues seen with KVM equipment on bootup, with
omapdrm/kms by making sure the TFP410 is powered up, via pulling up GPIO2 on
the twl4030.

https://groups.google.com/d/msg/beagleboard/Wk9SLuw-EvY/oCxJcAHufAMJ

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 0c514dc..c48778f 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -131,14 +131,14 @@
 
 &twl_gpio {
 	ti,use-leds;
-	/* pullups: BIT(1) */
-	ti,pullups = <0x000002>;
+	/* pullups: BIT(1), BIT(2) */
+	ti,pullups = <0x000006>;
 	/*
 	 * pulldowns:
-	 * BIT(2), BIT(6), BIT(7), BIT(8), BIT(13)
+	 * BIT(6), BIT(7), BIT(8), BIT(13)
 	 * BIT(15), BIT(16), BIT(17)
 	 */
-	ti,pulldowns = <0x03a1c4>;
+	ti,pulldowns = <0x03a1c0>;
 };
 
 &usb_otg_hs {
-- 
1.8.4.rc3
