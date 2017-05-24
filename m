From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 19:17:24 +0800
Subject: [PATCH 2/2] ARM: sun8i: v3s: add pinmux for LCD pins of V3s SoC
In-Reply-To: <20170524111724.28431-1-icenowy@aosc.io>
References: <20170524111724.28431-1-icenowy@aosc.io>
Message-ID: <20170524111724.28431-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features a set of pins that have functionality of RGB
LCD, the pins are at different pin ban than other SoCs.

Add pinctrl node for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 3a06dc5b3746..81e5406661b4 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -297,6 +297,15 @@
 				function = "i2c0";
 			};
 
+			lcd_rgb666_pins: lcd_rgb666 {
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
