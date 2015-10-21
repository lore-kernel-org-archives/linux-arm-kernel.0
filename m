From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 22:52:59 +0200
Subject: [PATCH 06/13] ARM: sun7i: Add audio codec clock
In-Reply-To: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1445460786-18280-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio codec functional clock is a child of PLL2 and is used to control
the audio rate, enable it in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 433ec1415e56..f4440f6d9621 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
+#include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -500,6 +501,14 @@
 			clock-output-names = "spi3";
 		};
 
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "codec";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun5i-a13-mbus-clk";
-- 
2.6.2
