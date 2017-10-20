From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:29:01 +0200
Subject: [PATCH 34/42] ARM: dts: r8a7790: Add clocks for CA7 CPU cores
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <aea0089ae8058a9bf4c9766f3208809fc28c99f0.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently only the CPU cores in the CA15 cluster have clocks properties.
Add the missing clocks properties for the CPU cores in the CA7 cluster
to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e85eb42f97e8..2f017fee4009 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -105,6 +105,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z2>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
 			capacity-dmips-mhz = <539>;
@@ -115,6 +116,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z2>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU1>;
 			next-level-cache = <&L2_CA7>;
 			capacity-dmips-mhz = <539>;
@@ -125,6 +127,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z2>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU2>;
 			next-level-cache = <&L2_CA7>;
 			capacity-dmips-mhz = <539>;
@@ -135,6 +138,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z2>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU3>;
 			next-level-cache = <&L2_CA7>;
 			capacity-dmips-mhz = <539>;
-- 
2.11.0
