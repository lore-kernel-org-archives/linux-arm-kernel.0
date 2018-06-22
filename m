From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 22 Jun 2018 21:05:24 +0800
Subject: [PATCH v2 7/7] arm64: allwinner: a64: add HDMI regulator to all DTs'
 simplefb_hdmi
Message-ID: <20180622130524.57131-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On usual A64 board design the power of HDMI controller is connected to
DLDO1 of the AXP803 PMIC. If this regulator is shut down, the HDMI
output will be blank. Therefore the simplefb driver should keep this
regulator on.

Add the regulator to all currently available A64 boards' simplefb_hdmi
device node, if the board is capable of outputing HDMI.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Added HDMI regulator configuration on two A64 laptops (Pinebook and
  TERES-I).

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts       | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts        | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts     | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts         | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts          | 4 ++++
 8 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 0716b1441187..094cfed13df9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -296,6 +296,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index e2dce48fa29a..98dbff19f5cc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -195,6 +195,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 3b3081b10ecb..3f531393eaee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -214,6 +214,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index bf42690a3361..1221764f5719 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -191,6 +191,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index a75825798a71..1b9b92e541d2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -229,6 +229,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 /* On Euler connector */
 &spdif {
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 58253d6f9be1..104f8a6c6ca8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -263,6 +263,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index abe179de35d7..c21f2331add6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -134,6 +134,10 @@
 	regulator-name = "vcc-wifi";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index d9baab3dc96b..9065f30a758e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -253,6 +253,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.1
