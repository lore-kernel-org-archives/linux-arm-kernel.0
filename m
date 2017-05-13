From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 16:33:31 +0200
Subject: [PATCH v2 12/18] arm64: dts: meson-gxbb-vega-s95: Fix node order
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <20170513143337.14278-13-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort nodes referenced by label alphabetically.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Rebased (new nodes added)
 
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 54 +++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index f4bfee8e2e08..346753fb6324 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -111,18 +111,6 @@
 	};
 };
 
-&uart_AO {
-	status = "okay";
-	pinctrl-0 = <&uart_ao_a_pins>;
-	pinctrl-names = "default";
-};
-
-&ir {
-	status = "okay";
-	pinctrl-0 = <&remote_input_ao_pins>;
-	pinctrl-names = "default";
-};
-
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_pins>;
@@ -149,21 +137,18 @@
 	};
 };
 
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
+&ir {
 	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
 };
 
-&usb1 {
+&pwm_ef {
 	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
 };
 
 /* Wireless SDIO Module */
@@ -229,10 +214,25 @@
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
2.12.0
