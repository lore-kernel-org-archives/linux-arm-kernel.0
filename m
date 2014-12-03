From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:36:01 +0800
Subject: [PATCH 06/10] ARM: dts: sun9i: Add mmc controller nodes to the A80
 dtsi
In-Reply-To: <1417588565-26215-1-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
Message-ID: <1417588565-26215-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 has 4 mmc controllers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f425d9d..c766698 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -325,6 +325,50 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&mmc_config_clk 0>, <&mmc0_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&mmc_config_clk 0>;
+			reset-names = "ahb";
+			interrupts = <0 60 4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&mmc_config_clk 1>, <&mmc1_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&mmc_config_clk 1>;
+			reset-names = "ahb";
+			interrupts = <0 61 4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&mmc_config_clk 2>, <&mmc2_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&mmc_config_clk 2>;
+			reset-names = "ahb";
+			interrupts = <0 62 4>;
+			status = "disabled";
+		};
+
+		mmc3: mmc at 01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&mmc_config_clk 3>, <&mmc3_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&mmc_config_clk 3>;
+			reset-names = "ahb";
+			interrupts = <0 63 4>;
+			status = "disabled";
+		};
+
 		mmc_config_clk: clk at 01c23000 {
 			compatible = "allwinner,sun9i-a80-mmc-clk";
 			reg = <0x01c13000 0x10>;
-- 
2.1.3
