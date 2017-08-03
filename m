From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Aug 2017 16:14:09 +0800
Subject: [PATCH 6/8] ARM: sun8i: a83t: Add device node for USB OTG controller
In-Reply-To: <20170803081411.22389-1-wens@csie.org>
References: <20170803081411.22389-1-wens@csie.org>
Message-ID: <20170803081411.22389-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB OTG controller found on the A83T is compatible with the one
found on the A33.

Add a device node for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 6039f1ea6810..f996bd343e50 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -242,6 +242,20 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c19000 {
+			compatible = "allwinner,sun8i-a83t-musb",
+				     "allwinner,sun8i-a33-musb";
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
 		usbphy: phy at 1c19400 {
 			compatible = "allwinner,sun8i-a83t-usb-phy";
 			reg = <0x01c19400 0x10>,
-- 
2.13.3
