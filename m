From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 17:32:03 +0200
Subject: [PATCH 6/7] ARM: sun8i: a33: Add RGB666 pins
In-Reply-To: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
Message-ID: <20160901153204.11217-7-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD output needs to be muxed. Add the proper pinctrl node.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 5f9dbd17eb50..d5f93c05846f 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -300,6 +300,16 @@
 	interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 
+	tcon0_rgb666_pins_a: tcon0_rgb666 at 0 {
+	        allwinner,pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+	                         "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+	                         "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+	                         "PD24", "PD25", "PD26", "PD27";
+		allwinner,function = "lcd0";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	uart0_pins_b: uart0 at 1 {
 		allwinner,pins = "PB0", "PB1";
 		allwinner,function = "uart0";
-- 
2.9.2
