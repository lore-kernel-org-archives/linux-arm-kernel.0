From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 23 Apr 2017 18:37:53 +0800
Subject: [PATCH v5 10/11] ARM: dts: sun8i: add pinmux for LCD pins of V3s SoC
In-Reply-To: <20170423103754.50012-1-icenowy@aosc.io>
References: <20170423103754.50012-1-icenowy@aosc.io>
Message-ID: <20170423103754.50012-11-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features a set of pins that have functionality of RGB
LCD, the pins are at different pin ban than other SoCs.

Add pinctrl node for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 0a895179d8ae..a37d68b227bc 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -297,6 +297,15 @@
 				function = "i2c0";
 			};
 
+			lcd_rgb666_pins: lcd_rgb666 at 0 {
+				pins = "PE0", "PE1", "PE2", "PE3", "PE4",
+				       "PE5", "PE6", "PE7", "PE8", "PE9",
+				       "PE10", "PE11", "PE12", "PE13", "PE14",
+				       "PE15", "PE16", "PE17", "PE18", "PE19",
+				       "PE23", "PE24";
+				function = "lcd";
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				pins = "PB8", "PB9";
 				function = "uart0";
-- 
2.12.2
