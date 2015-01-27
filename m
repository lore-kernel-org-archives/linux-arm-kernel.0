From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Jan 2015 03:54:11 +0800
Subject: [PATCH v3 06/10] ARM: dts: sun9i: Add USB host controller nodes to
 a80 dtsi
In-Reply-To: <1422388455-25923-1-git-send-email-wens@csie.org>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
Message-ID: <1422388455-25923-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 has 3 EHCI/OHCI USB controllers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 70 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index d7ebd9390b01..9483b15bfda7 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -355,6 +355,28 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
+		ehci0: usb at 00a00000 {
+			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
+			reg = <0x00a00000 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_mod_clk 1>;
+			resets = <&usb_mod_clk 17>;
+			phys = <&usbphy1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 00a00400 {
+			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
+			reg = <0x00a00400 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_mod_clk 1>, <&usb_mod_clk 2>;
+			resets = <&usb_mod_clk 17>;
+			phys = <&usbphy1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		usbphy1: phy at 00a00800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a00800 0x4>;
@@ -366,6 +388,32 @@
 			#phy-cells = <0>;
 		};
 
+		ehci1: usb at 00a01000 {
+			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
+			reg = <0x00a01000 0x100>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_mod_clk 3>;
+			resets = <&usb_mod_clk 18>;
+			phys = <&usbphy2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		/*
+		 * Even though ohci1 exists, it is never used as
+		 * usb1 only has HSIC pins routed externally
+		 */
+		ohci1: usb at 00a01400 {
+			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
+			reg = <0x00a01400 0x100>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_mod_clk 3>, <&usb_mod_clk 4>;
+			resets = <&usb_mod_clk 18>;
+			phys = <&usbphy2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		usbphy2: phy at 00a01800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a01800 0x4>;
@@ -380,6 +428,28 @@
 			phy_type = "hsic";
 		};
 
+		ehci2: usb at 00a02000 {
+			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
+			reg = <0x00a02000 0x100>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_mod_clk 5>;
+			resets = <&usb_mod_clk 19>;
+			phys = <&usbphy3>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci2: usb at 00a02400 {
+			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
+			reg = <0x00a02400 0x100>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_mod_clk 5>, <&usb_mod_clk 6>;
+			resets = <&usb_mod_clk 19>;
+			phys = <&usbphy3>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		usbphy3: phy at 00a02800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a02800 0x4>;
-- 
2.1.4
