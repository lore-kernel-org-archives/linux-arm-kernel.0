From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 25 Nov 2013 15:31:30 +0530
Subject: [PATCH v3 10/10] arm/dts: added dt properties to adapt to the new phy
 framwork
In-Reply-To: <1385373690-12170-1-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
Message-ID: <1385373690-12170-11-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added device tree bindings for dwc3, usb2 and usb3 PHYs. The documentation
of these can be found at Documentation/devicetree/bindings/phy/phy-bindings.txt
and Documentation/devicetree/bindings/phy/ti-phy.txt.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 29a6354..c135677 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -678,6 +678,8 @@
 				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 				usb-phy = <&usb2_phy>, <&usb3_phy>;
+				phys = <&usb2_phy>, <&usb3_phy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				dr_mode = "peripheral";
 				tx-fifo-resize;
 			};
@@ -694,6 +696,7 @@
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
 				ctrl-module = <&omap_control_usb2phy>;
+				#phy-cells = <0>;
 			};
 
 			usb3_phy: usb3phy at 4a084400 {
@@ -703,6 +706,7 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				#phy-cells = <0>;
 			};
 		};
 
-- 
1.7.10.4
