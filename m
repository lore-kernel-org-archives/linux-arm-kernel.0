From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Jan 2015 09:37:28 +0800
Subject: [PATCH v3 06/13] ARM: dts: sun9i: Add mmc config clock nodes
In-Reply-To: <1421113055-17867-1-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
Message-ID: <1421113055-17867-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree nodes for the mmc config clock nodes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 9d0a66c14caf..9b3b71c6f29b 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -333,6 +333,19 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
+		mmc_config_clk: clk at 01c13000 {
+			compatible = "allwinner,sun9i-a80-mmc-config-clk";
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
2.1.4
