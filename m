From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 19 Jan 2017 15:59:04 +0100
Subject: [PATCH v1 3/3] ARM: dts: tango4: Import USB nodes
In-Reply-To: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
References: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
Message-ID: <48dc3582-c5d0-ad19-0a4a-bbbfd7e7552d@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tango4 provides 2 USB 2.0 controllers.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/boot/dts/tango4-common.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
index 2eb92a2649ed..0c8cad4d6ee6 100644
--- a/arch/arm/boot/dts/tango4-common.dtsi
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -113,6 +113,36 @@
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		usb0: usb at 21400 {
+			compatible = "chipidea,usb2";
+			reg = <0x21400 0x200>;
+			interrupts = <40 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy>;
+			phy-names = "usb-phy";
+		};
+
+		usb0_phy: phy at 21700 {
+			compatible = "sigma,smp8642-usb-phy";
+			reg = <0x21700 0x100>;
+			#phy-cells = <0>;
+			clocks = <&clkgen USB_CLK>;
+		};
+
+		usb1: usb at 25400 {
+			compatible = "chipidea,usb2";
+			reg = <0x25400 0x200>;
+			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb1_phy>;
+			phy-names = "usb-phy";
+		};
+
+		usb1_phy: phy at 25700 {
+			compatible = "sigma,smp8642-usb-phy";
+			reg = <0x25700 0x100>;
+			#phy-cells = <0>;
+			clocks = <&clkgen USB_CLK>;
+		};
+
 		eth0: ethernet at 26000 {
 			compatible = "sigma,smp8734-ethernet";
 			reg = <0x26000 0x800>;
-- 
2.10.0
