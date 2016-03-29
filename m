From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 29 Mar 2016 17:22:32 +0800
Subject: [PATCH resend v2 9/9] ARM: dts: sun9i: cubieboard4: Disable dummy
 regulators vcc3v0, vcc3v3, vcc5v0
In-Reply-To: <1459243352-23344-1-git-send-email-wens@csie.org>
References: <1459243352-23344-1-git-send-email-wens@csie.org>
Message-ID: <1459243352-23344-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These 3 regulators are provided in sunxi-common-regulators.dtsi.
3.0V/3.3V and 5.0V are commonly used voltages in Allwinner devices.
These dummy regulators provide a stand-in when bindings that require
one, but the real regulator is not supported yet.

Since these are no longer needed, we can disable them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 8d8af1189d87..84a12fef5768 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -255,6 +255,18 @@
 
 #include "axp809.dtsi"
 
+&reg_vcc3v0 {
+	status = "disabled";
+};
+
+&reg_vcc3v3 {
+	status = "disabled";
+};
+
+&reg_vcc5v0 {
+	status = "disabled";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.7.0
