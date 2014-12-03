From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:36:00 +0800
Subject: [PATCH 05/10] ARM: dts: sun9i: Add mmc config clock nodes
In-Reply-To: <1417588565-26215-1-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
Message-ID: <1417588565-26215-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree nodes for the mmc config clock nodes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f3cac3a..f425d9d 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -325,6 +325,19 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
+		mmc_config_clk: clk at 01c23000 {
+			compatible = "allwinner,sun9i-a80-mmc-clk";
+			reg = <0x01c13000 0x10>;
+			clocks = <&ahb0_gates 8>;
+			clock-names = "ahb";
+			resets = <&ahb0_resets 8>;
+			reset-names = "ahb";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			clock-output-names = "mmc0_config", "mmc1_config",
+					     "mmc2_config", "mmc3_config";
+		};
+
 		gic: interrupt-controller at 01c41000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c41000 0x1000>,
-- 
2.1.3
