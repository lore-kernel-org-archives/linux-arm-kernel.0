From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 17 Nov 2014 14:35:44 +0100
Subject: [PATCH v8 10/13] ARM: dts: berlin: add BG2Q nodes for USB support
In-Reply-To: <1416231347-27193-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1416231347-27193-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1416231347-27193-11-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds nodes describing the Marvell Berlin BG2Q USB PHY and USB. The BG2Q
SoC has 3 USB host controller, compatible with ChipIdea.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 2de8d6f8973c..834142bdfbb1 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -114,6 +114,40 @@
 			#interrupt-cells = <3>;
 		};
 
+		usb_phy2: phy at a2f400 {
+			compatible = "marvell,berlin2-usb-phy";
+			reg = <0xa2f400 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x104 14>;
+			status = "disabled";
+		};
+
+		usb2: usb at a30000 {
+			compatible = "chipidea,usb2";
+			reg = <0xa30000 0x10000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB2>;
+			phys = <&usb_phy2>;
+			phy-names = "usb-phy";
+			status = "disabled";
+		};
+
+		usb_phy0: phy at b74000 {
+			compatible = "marvell,berlin2-usb-phy";
+			reg = <0xb74000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x104 12>;
+			status = "disabled";
+		};
+
+		usb_phy1: phy at b78000 {
+			compatible = "marvell,berlin2-usb-phy";
+			reg = <0xb78000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x104 13>;
+			status = "disabled";
+		};
+
 		eth0: ethernet at b90000 {
 			compatible = "marvell,pxa168-eth";
 			reg = <0xb90000 0x10000>;
@@ -365,6 +399,26 @@
 			};
 		};
 
+		usb0: usb at ed0000 {
+			compatible = "chipidea,usb2";
+			reg = <0xed0000 0x10000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB0>;
+			phys = <&usb_phy0>;
+			phy-names = "usb-phy";
+			status = "disabled";
+		};
+
+		usb1: usb at ee0000 {
+			compatible = "chipidea,usb2";
+			reg = <0xee0000 0x10000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB1>;
+			phys = <&usb_phy1>;
+			phy-names = "usb-phy";
+			status = "disabled";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -457,5 +511,6 @@
 				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
 	};
 };
-- 
2.1.0
