From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 29 Jan 2014 15:34:22 +0100
Subject: [RFC PATCH v2 12/14] ARM: sunxi/dt: enable NAND on cubietruck board
In-Reply-To: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1391006064-28890-13-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the NFC and describe the NAND flash connected to this controller.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts |   31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8a1009d..031de97 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -19,6 +19,37 @@
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		nfc: nand at 01c03000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
+			status = "okay";
+
+			nand at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0>;
+				allwinner,rb = <0>;
+				nand-ecc-mode = "soft_bch";
+
+				/* nand timings */
+				tCLS-min = <6>;
+				tCLH-min = <3>;
+				tCS-min = <20>;
+				tCH-min = <5>;
+				tWP-min = <8>;
+				tWH-min = <6>;
+				tALS-min = <6>;
+				tDS-min = <6>;
+				tDH-min = <2>;
+				tRR-min = <20>;
+				tALH-min = <3>;
+				tRP-min = <8>;
+				tREH-min = <6>;
+				tRC-min = <16>;
+				tWC-min = <16>;
+			};
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubietruck: led_pins at 0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
-- 
1.7.9.5
