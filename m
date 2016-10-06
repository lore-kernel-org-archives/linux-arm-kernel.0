From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:28 +0800
Subject: [PATCH 8/9] ARM: dts: sun6i: Add A31 LCD0 RGB888 pins
In-Reply-To: <20161006160629.11198-1-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
Message-ID: <20161006160629.11198-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD0 controller on the A31 can do RGB output up to 8 bits per
channel. Add the pins for RGB888 output.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 4d2c7786b92a..2e8bf93dcfb2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -540,6 +540,19 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			lcd0_rgb888_pins: lcd0_rgb888 {
+				allwinner,pins = "PD0", "PD1", "PD2", "PD3",
+						 "PD4", "PD5", "PD6", "PD7",
+						 "PD8", "PD9", "PD10", "PD11",
+						 "PD12", "PD13", "PD14", "PD15",
+						 "PD16", "PD17", "PD18", "PD19",
+						 "PD20", "PD21", "PD22", "PD23",
+						 "PD24", "PD25", "PD26", "PD27";
+				allwinner,function = "lcd0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0", "PF1", "PF2",
 						 "PF3", "PF4", "PF5";
-- 
2.9.3
