From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 12 Mar 2014 19:07:44 +0100
Subject: [PATCH v3 9/9] ARM: sunxi/dt: enable NAND on cubietruck board
In-Reply-To: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1394647664-8258-10-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the NFC and describe the NAND flash connected to this controller.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index f9dcb61..7b48539 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -19,6 +19,23 @@
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		nfc: nand at 01c03000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
+			status = "okay";
+
+			nand at 0 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0>;
+				allwinner,rb = <0>;
+				nand-ecc-mode = "hw";
+				onfi,nand-timing-mode = <0x1f>;
+				nand-ecc-strength = <40>;
+				nand-ecc-step-size = <1024>;
+			};
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubietruck: led_pins at 0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
-- 
1.7.9.5
