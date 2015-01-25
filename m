From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 25 Jan 2015 15:36:08 +0100
Subject: [PATCH] ARM: dts: sun5i: Enable axp209 support on A13-OLinuxIno
Message-ID: <1422196568-18148-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (non micro) A13-OLinuxIno has an axp203 pmic, enable support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 3649e78..76a4bde 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -156,6 +156,15 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
-- 
2.1.0
