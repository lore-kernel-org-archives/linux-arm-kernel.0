From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 15:54:09 +0900
Subject: [PATCH v2 1/4] ARM: dts: sun8i: Add SPI pinctrl node in H3
In-Reply-To: <20161028065412.23008-1-woogyom.kim@gmail.com>
References: <20161028065412.23008-1-woogyom.kim@gmail.com>
Message-ID: <20161028065412.23008-2-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 supports two SPI controllers. Four pins (MOSI, MISO, SCLK, SS) are
configured through the pinctrl subsystem.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 75a8654..8a59d8d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -381,6 +381,20 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			spi0_pins: spi0 {
+				allwinner,pins = "PC0", "PC1", "PC2", "PC3";
+				allwinner,function = "spi0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi1_pins: spi1 {
+				allwinner,pins = "PA15", "PA16", "PA14", "PA13";
+				allwinner,function = "spi1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PA4", "PA5";
 				allwinner,function = "uart0";
-- 
2.9.3
