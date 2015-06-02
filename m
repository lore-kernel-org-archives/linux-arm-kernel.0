From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Jun 2015 20:29:12 +0800
Subject: [PATCH 3/3] ARM: dts: sun8i: sina33: Enable USB hosts
In-Reply-To: <1433248152-13753-1-git-send-email-wens@csie.org>
References: <1433248152-13753-1-git-send-email-wens@csie.org>
Message-ID: <1433248152-13753-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sina33 SDK board exposes the EHCI/OHCI USB host pair.
VBUS for this port is always on and non-controllable.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 5788c29cb56a..1d5390d4e03a 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -63,6 +63,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &lradc {
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
@@ -113,6 +117,10 @@
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pio {
 	mmc0_cd_pin_sina33: mmc0_cd_pin at 0 {
 		allwinner,pins = "PB4";
@@ -127,3 +135,8 @@
 	pinctrl-0 = <&uart0_pins_b>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+	usb1_vbus-supply = <&reg_vcc5v0>; /* USB1 VBUS is always on */
+};
-- 
2.1.4
