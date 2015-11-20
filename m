From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 14:59:10 +0100
Subject: [PATCH 4/4] ARM: dts: sun5i: Add i2c axp152 pmic support for Auxtek
 T004 boards
In-Reply-To: <1448027950-14629-1-git-send-email-hdegoede@redhat.com>
References: <1448027950-14629-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448027950-14629-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael van Slingerland <michael@deviousops.nl>

Add a node describing the AXP152 pmic used on Auxtek T004 boards.

Signed-off-by: Michael van Slingerland <michael@deviousops.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index 2b3511e..a790ec8 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -86,6 +86,20 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp152: pmic at 30 {
+		compatible = "x-powers,axp152";
+		reg = <0x30>;
+		interrupts = <0>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_t004>;
-- 
2.5.0
