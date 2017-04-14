From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 14 Apr 2017 21:15:54 +0800
Subject: [PATCH 1/2] arm64: allwinner: a64: add EHCI0/OHCI0 nodes to A64 DTSI
Message-ID: <20170414131555.9431-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC features a pair of EHCI/OHCI controllers that can be
set to wire to USB0 port (the OTG-capable one), which can be used to
provide a better performance in host mode.

Add their device tree nodes.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index c7f669f5884f..65a344d9cea4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -204,6 +204,28 @@
 			#phy-cells = <1>;
 		};
 
+		ehci0: usb at 01c1a000 {
+			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
+			reg = <0x01c1a000 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c1a400 {
+			compatible = "allwinner,sun50i-a64-ohci", "generic-ohci";
+			reg = <0x01c1a400 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			status = "disabled";
+		};
+
 		ehci1: usb at 01c1b000 {
 			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
-- 
2.12.2
