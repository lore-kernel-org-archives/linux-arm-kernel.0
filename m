From: surenderp@techveda.org (surenderp at techveda.org)
Date: Tue, 27 Jun 2017 17:45:35 +0530
Subject: [PATCH] arm: boot: dts: artpec6: Remove unnecessary interrupt-parent
 property from sub-nodes
Message-ID: <1498565735-8208-1-git-send-email-surenderp@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Surender Polsani <surenderp@techveda.org>

"interrupt-parent" property is declared in root node, so it is global
to all nodes. This property is re-declared in few sub-nodes. To avoid
duplication this property is removed from following sub-nodes:
pmu, amba at 0, amba at 0/ethernet.

Signed-off-by: Surender Polsani <surenderp@techveda.org>
---
 arch/arm/boot/dts/artpec6.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 767cbe8..2ed1177 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -151,7 +151,6 @@
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>, <&cpu1>;
-		interrupt-parent = <&intc>;
 	};
 
 	pcie: pcie at f8050000 {
@@ -185,7 +184,6 @@
 		compatible = "simple-bus";
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
-		interrupt-parent = <&intc>;
 		ranges;
 		dma-ranges = <0x80000000 0x00000000 0x40000000>;
 		dma-coherent;
@@ -195,7 +193,6 @@
 			clocks = <&eth_phy_ref_clk>,
 				<&clkctrl ARTPEC6_CLK_ETH_ACLK>;
 			compatible = "snps,dwc-qos-ethernet-4.10";
-			interrupt-parent = <&intc>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xf8010000 0x4000>;
 
-- 
1.9.1
