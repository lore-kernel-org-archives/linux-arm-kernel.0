From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Feb 2016 18:27:44 +0800
Subject: [PATCH 11/11] ARM: dts: sun9i: cubieboard4: Disable dummy regulators
 vcc3v0, vcc3v3, vcc5v0
In-Reply-To: <1454408864-24112-1-git-send-email-wens@csie.org>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
Message-ID: <1454408864-24112-12-git-send-email-wens@csie.org>
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
index 4d56dc69713c..98d9dc2d5259 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -245,6 +245,18 @@
 	regulator-name = "vcc-rtc-vdd1v8-io";
 };
 
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
