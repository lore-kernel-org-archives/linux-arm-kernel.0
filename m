From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 20 Jan 2017 23:21:12 +0100
Subject: [PATCH 12/18] ARM64: dts: meson-gxbb-vega-s95: Reorder nodes
In-Reply-To: <20170120222118.21476-1-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
Message-ID: <20170120222118.21476-13-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort nodes referenced by label alphabetically.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 51 +++++++++++-----------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index e688e8971a95..81024886d232 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -111,11 +111,10 @@
 	};
 };
 
-&uart_AO {
+&ethmac {
 	status = "okay";
-	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
-
 };
 
 &ir {
@@ -124,27 +123,12 @@
 	pinctrl-names = "default";
 };
 
-&ethmac {
+&pwm_ef {
 	status = "okay";
-	pinctrl-0 = <&eth_rgmii_pins>;
+	pinctrl-0 = <&pwm_e_pins>;
 	pinctrl-names = "default";
-};
-
-&usb0_phy {
-	status = "okay";
-	phy-supply = <&usb_vbus>;
-};
-
-&usb1_phy {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-};
-
-&usb1 {
-	status = "okay";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
 };
 
 /* Wireless SDIO Module */
@@ -210,10 +194,25 @@
 	vmmcq-sumpply = <&vcc_1v8>;
 };
 
-&pwm_ef {
+&uart_AO {
 	status = "okay";
-	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_FCLK_DIV4>;
-	clock-names = "clkin0";
+};
+
+&usb0_phy {
+	status = "okay";
+	phy-supply = <&usb_vbus>;
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
 };
-- 
2.10.2
