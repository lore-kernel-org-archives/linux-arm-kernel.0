From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:14 +0200
Subject: [PATCH 14/20] ARM: sun5i: a13: Add LCD pins
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-15-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RGB bus can be used in several configurations, one of which being the
RGB666.

Add a pinctrl group for that case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 263d46dbc7e6..79b5d513c142 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -237,6 +237,16 @@
 &pio {
 	compatible = "allwinner,sun5i-a13-pinctrl";
 
+	lcd_rgb666_pins: lcd_rgb666 at 0 {
+		allwinner,pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				 "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+				 "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+				 "PD24", "PD25", "PD26", "PD27";
+		allwinner,function = "lcd0";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	uart1_pins_a: uart1 at 0 {
 		allwinner,pins = "PE10", "PE11";
 		allwinner,function = "uart1";
-- 
2.8.2
