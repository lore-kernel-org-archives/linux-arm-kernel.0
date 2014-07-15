From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Jul 2014 01:15:45 +0800
Subject: [PATCH v2 3/5] ARM: dts: sun6i: Add A31 GMAC gigabit ethernet
 controller node
In-Reply-To: <1405444547-21870-1-git-send-email-wens@csie.org>
References: <1405444547-21870-1-git-send-email-wens@csie.org>
Message-ID: <1405444547-21870-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has the same GMAC found on the A20 SoC, except it has
an extra reset control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index b78a5aa..578fde2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -691,6 +691,23 @@
 			status = "disabled";
 		};
 
+		gmac: ethernet at 01c30000 {
+			compatible = "allwinner,sun7i-a20-gmac";
+			reg = <0x01c30000 0x1054>;
+			interrupts = <0 82 4>;
+			interrupt-names = "macirq";
+			clocks = <&ahb1_gates 17>, <&gmac_tx_clk>;
+			clock-names = "stmmaceth", "allwinner_gmac_tx";
+			resets = <&ahb1_rst 17>;
+			reset-names = "stmmaceth";
+			snps,pbl = <2>;
+			snps,fixed-burst;
+			snps,force_sf_dma_mode;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		timer at 01c60000 {
 			compatible = "allwinner,sun6i-a31-hstimer", "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
-- 
2.0.1
