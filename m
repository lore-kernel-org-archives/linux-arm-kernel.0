From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Feb 2014 11:32:21 +0800
Subject: [PATCH v3 3/8] ARM: dts: sun7i: Add GMAC controller node to sun7i DTSI
In-Reply-To: <1391398346-5094-1-git-send-email-wens@csie.org>
References: <1391398346-5094-1-git-send-email-wens@csie.org>
Message-ID: <1391398346-5094-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index fc7f470..5fbac23 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -630,6 +630,21 @@
 			status = "disabled";
 		};
 
+		gmac: ethernet at 01c50000 {
+			compatible = "allwinner,sun7i-a20-gmac";
+			reg = <0x01c50000 0x10000>;
+			interrupts = <0 85 4>;
+			interrupt-names = "macirq";
+			clocks = <&ahb_gates 49>, <&gmac_tx_clk>;
+			clock-names = "stmmaceth", "allwinner_gmac_tx";
+			snps,pbl = <2>;
+			snps,fixed-burst;
+			snps,force_sf_dma_mode;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		hstimer at 01c60000 {
 			compatible = "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
-- 
1.9.rc1
