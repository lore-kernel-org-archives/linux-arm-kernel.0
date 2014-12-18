From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Dec 2014 15:00:53 +0800
Subject: [PATCH v2 06/11] ARM: dts: sunxi: Use label to reference pio in
 sunxi-common-regulators
In-Reply-To: <1418886058-8145-1-git-send-email-wens@csie.org>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
Message-ID: <1418886058-8145-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the label to reference the pin controller node, so that we can use
sunxi-common-regulators with sunxi families that don't share the same
address space mappings, such as sun9i.

This patch is mostly space changes due to the reduction of node parents.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 54 +++++++++++++-------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index d887663..4bfb0c0 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -47,39 +47,37 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/ {
-	soc at 01c00000 {
-		pio: pinctrl at 01c20800 {
-			ahci_pwr_pin_a: ahci_pwr_pin at 0 {
-				allwinner,pins = "PB8";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <0>;
-				allwinner,pull = <0>;
-			};
+&pio {
+	ahci_pwr_pin_a: ahci_pwr_pin at 0 {
+		allwinner,pins = "PB8";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <0>;
+		allwinner,pull = <0>;
+	};
 
-			usb0_vbus_pin_a: usb0_vbus_pin at 0 {
-				allwinner,pins = "PB9";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <0>;
-				allwinner,pull = <0>;
-			};
+	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
+		allwinner,pins = "PB9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <0>;
+		allwinner,pull = <0>;
+	};
 
-			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
-				allwinner,pins = "PH6";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <0>;
-				allwinner,pull = <0>;
-			};
+	usb1_vbus_pin_a: usb1_vbus_pin at 0 {
+		allwinner,pins = "PH6";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <0>;
+		allwinner,pull = <0>;
+	};
 
-			usb2_vbus_pin_a: usb2_vbus_pin at 0 {
-				allwinner,pins = "PH3";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <0>;
-				allwinner,pull = <0>;
-			};
-		};
+	usb2_vbus_pin_a: usb2_vbus_pin at 0 {
+		allwinner,pins = "PH3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <0>;
+		allwinner,pull = <0>;
 	};
+};
 
+/ {
 	reg_ahci_5v: ahci-5v {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.1.3
