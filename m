From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:29:00 +0200
Subject: [PATCH 33/42] ARM: dts: r8a7790: Add missing clocks for secondary
 CA15 CPU cores
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <aa4c2fdf495f000fa9ae57c073c0c4575c21983e.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently only the primary CPU in the CA15 cluster has a clocks
property, while the secondary CPU cores are driven by the same clock.
Add the missing clocks properties to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index f247beb3863f..e85eb42f97e8 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -72,6 +72,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z>;
 			power-domains = <&sysc R8A7790_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
 			capacity-dmips-mhz = <1024>;
@@ -82,6 +83,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z>;
 			power-domains = <&sysc R8A7790_PD_CA15_CPU2>;
 			next-level-cache = <&L2_CA15>;
 			capacity-dmips-mhz = <1024>;
@@ -92,6 +94,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z>;
 			power-domains = <&sysc R8A7790_PD_CA15_CPU3>;
 			next-level-cache = <&L2_CA15>;
 			capacity-dmips-mhz = <1024>;
-- 
2.11.0
