From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Sep 2015 15:35:37 +0800
Subject: [PATCH 2/4] ARM: dts: sun8i: Add PWM channel 0 pinmux setting for
 A23/A33
In-Reply-To: <1442561739-6824-1-git-send-email-wens@csie.org>
References: <1442561739-6824-1-git-send-email-wens@csie.org>
Message-ID: <1442561739-6824-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM controller has 2 outputs, with one usable pin for each.

Add a pinmux setting for the first channel. This is often used
for backlight dimming on tablets.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index e7054304018a..8f4db82084c5 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -412,6 +412,13 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			pwm0_pins: pwm0 {
+				allwinner,pins = "PH0";
+				allwinner,function = "pwm0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PH2", "PH3";
 				allwinner,function = "i2c0";
-- 
2.5.1
