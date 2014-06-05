From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu,  5 Jun 2014 17:48:45 +0200
Subject: [PATCH 8/9] ARM: dts: berlin: add BG2Q nodes for USB support
In-Reply-To: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401983326-19205-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds nodes describing the Marvell Berlin BG2Q USB PHY and USB. The BG2Q
SoC has 3 USB host controller, compatible with ChipIdea.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index b74e5ec66354..a6902ea5580c 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -87,6 +87,39 @@
 			#interrupt-cells = <3>;
 		};
 
+		usb_phy2: usbphy at a2f400 {
+			compatible = "marvell,berlin-usbphy";
+			reg = <0xa2f400 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 14>;
+			status = "disabled";
+		};
+
+		usb2: usb at a30000 {
+			compatible = "marvell,berlin-usb";
+			reg = <0xa30000 0x10000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB2>;
+			marvell,usbphy = <&usb_phy2>;
+			status = "disabled";
+		};
+
+		usb_phy0: usbphy at b74000 {
+			compatible = "marvell,berlin-usbphy";
+			reg = <0xb74000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 12>;
+			status = "disabled";
+		};
+
+		usb_phy1: usbphy at b78000 {
+			compatible = "marvell,berlin-usbphy";
+			reg = <0xb78000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 13>;
+			status = "disabled";
+		};
+
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -280,6 +313,24 @@
 			clock-names = "refclk";
 		};
 
+		usb0: usb at ed0000 {
+			compatible = "marvell,berlin-usb";
+			reg = <0xed0000 0x10000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB0>;
+			marvell,usbphy = <&usb_phy0>;
+			status = "disabled";
+		};
+
+		usb1: usb at ee0000 {
+			compatible = "marvell,berlin-usb";
+			reg = <0xee0000 0x10000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB1>;
+			marvell,usbphy = <&usb_phy1>;
+			status = "disabled";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
