From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Mar 2014 00:27:13 +0800
Subject: [PATCH 3/5] ARM: sun6i: dt: Add A31 GMAC gigabit ethernet controller
 node
In-Reply-To: <1394036835-22007-1-git-send-email-wens@csie.org>
References: <1394036835-22007-1-git-send-email-wens@csie.org>
Message-ID: <1394036835-22007-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has the same GMAC found on the A20 SoC, except it has
an extra reset control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ee09e4c..e958d5f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -429,6 +429,22 @@
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
+			snps,pbl = <2>;
+			snps,fixed-burst;
+			snps,force_sf_dma_mode;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		spi0: spi at 01c68000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c68000 0x1000>;
-- 
1.9.0
