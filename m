From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 22:52:57 +0200
Subject: [PATCH 04/13] ARM: sun4i: Add audio codec clock
In-Reply-To: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1445460786-18280-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio codec functional clock is a child of PLL2 and is used to control
the audio rate, enable it in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index c8595926a721..8993dfadd18c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -45,6 +45,7 @@
 
 #include <dt-bindings/thermal/thermal.h>
 
+#include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -490,6 +491,14 @@
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
 		};
+
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "codec";
+		};
 	};
 
 	soc at 01c00000 {
-- 
2.6.2
