From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  5 Dec 2015 21:16:47 +0800
Subject: [PATCH resend 6/6] ARM: dts: sun7i: Add VE (Video Engine) module
 clock node
In-Reply-To: <1449321407-4531-1-git-send-email-wens@csie.org>
References: <1449321407-4531-1-git-send-email-wens@csie.org>
Message-ID: <1449321407-4531-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The video engine has its own module clock, which also includes a
reset control for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 21169c0a6627..0940a788f824 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -527,6 +527,15 @@
 					     "dram_de_mp", "dram_ace";
 		};
 
+		ve_clk: clk at 01c2013c {
+			#clock-cells = <0>;
+			#reset-cells = <0>;
+			compatible = "allwinner,sun4i-a10-ve-clk";
+			reg = <0x01c2013c 0x4>;
+			clocks = <&pll4>;
+			clock-output-names = "ve";
+		};
+
 		codec_clk: clk at 01c20140 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-codec-clk";
-- 
2.6.2
