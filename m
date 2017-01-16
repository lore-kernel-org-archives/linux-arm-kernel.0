From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 17 Jan 2017 03:14:47 +0800
Subject: [PATCH 2/4] ARM: dts: sun8i: add MUSB node to H3 SoC
In-Reply-To: <20170116191449.50397-1-icenowy@aosc.xyz>
References: <20170116191449.50397-1-icenowy@aosc.xyz>
Message-ID: <20170116191449.50397-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have already H3 PHY support code to MUSB mode fixed, and the H3
MUSB controller supported, we can now add the MUSB node to the DTSI file
of H3.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 08fd0860bb6b..60dd88c7fb9a 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -206,6 +206,19 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c19000 {
+			compatible = "allwinner,sun8i-h3-musb";
+			reg = <0x01c19000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun8i-h3-usb-phy";
 			reg = <0x01c19400 0x2c>,
-- 
2.11.0
