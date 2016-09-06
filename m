From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Sep 2016 16:46:19 +0200
Subject: [PATCH v2 8/9] ARM: sun8i: a23/a33: Add RGB666 pins
In-Reply-To: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
Message-ID: <20160906144620.6322-9-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD output needs to be muxed. Add the proper pinctrl node.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7246663bacdd..7ea6de12040e 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -302,6 +302,16 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			lcd_rgb666_pins: lcd-rgb666 at 0 {
+				allwinner,pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+						 "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+			                         "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+			                         "PD24", "PD25", "PD26", "PD27";
+				allwinner,function = "lcd0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.9.3
