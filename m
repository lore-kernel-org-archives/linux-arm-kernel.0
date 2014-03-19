From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 19 Mar 2014 15:19:31 -0300
Subject: [PATCH 2/4] ARM: sun7i: fix PLL4 clock and add PLL8
In-Reply-To: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1395253173-30437-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner reworked the PLL4 clock in sun7i; so we need to change the
compatible. Additionally, PLL8 is compatible with this new PLL4
implementation, so let's add a node for it as well.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e766c6a..4e58ee5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -71,7 +71,7 @@
 
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-pll1-clk";
+			compatible = "allwinner,sun7i-a20-pll4-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll4";
@@ -93,6 +93,14 @@
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
 		};
 
+		pll8: clk at 01c20040 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun7i-a20-pll4-clk";
+			reg = <0x01c20040 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll8";
+		};
+
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-cpu-clk";
-- 
1.9.0
