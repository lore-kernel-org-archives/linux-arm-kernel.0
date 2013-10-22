From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:55:38 +0200
Subject: [PATCH] DTS: ARM: OMAP3-N900: Add vibrator device
Message-ID: <1382446538-28115-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Nokia N900's vibrator.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 2841002..55deb18 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -157,6 +157,13 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
+&twl {
+	twl_audio: audio {
+		compatible = "ti,twl4030-audio";
+		ti,enable-vibra = <1>;
+	};
+};
+
 &twl_keypad {
 	linux,keymap = < 0x00000010 /* KEY_Q */
 			 0x00010018 /* KEY_O */
-- 
1.8.4.rc3
