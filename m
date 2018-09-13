From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:24 +0200
Subject: [PATCH 01/13] ARM: dts: rcar: Correct SATA device sizes to 2 MiB
In-Reply-To: <cover.1536824376.git.horms+renesas@verge.net.au>
References: <cover.1536824376.git.horms+renesas@verge.net.au>
Message-ID: <441f61e3aa9e7386731ce1405044d484bd81f911.1536824376.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Update the SATA device nodes on R-Car H1, H2, and M2-W to use a 2 MiB
I/O space, as specified in Rev.1.0 of the R-Car H1 and R-Car Gen2
hardware user manuals.

See also commit e9f0089b2d8a3d45 ("arm64: dts: r8a7795: Correct SATA
device size to 2MiB").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 6b997bc016ee..03919714645a 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -344,7 +344,7 @@
 
 	sata: sata at fc600000 {
 		compatible = "renesas,sata-r8a7779", "renesas,rcar-sata";
-		reg = <0xfc600000 0x2000>;
+		reg = <0xfc600000 0x200000>;
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
 		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0925bdca438f..52a757f47bf0 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1559,7 +1559,7 @@
 		sata0: sata at ee300000 {
 			compatible = "renesas,sata-r8a7790",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee300000 0 0x2000>;
+			reg = <0 0xee300000 0 0x200000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
@@ -1570,7 +1570,7 @@
 		sata1: sata at ee500000 {
 			compatible = "renesas,sata-r8a7790",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee500000 0 0x2000>;
+			reg = <0 0xee500000 0 0x200000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 814>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 991ac6feedd5..25b6a99dd87a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1543,7 +1543,7 @@
 		sata0: sata at ee300000 {
 			compatible = "renesas,sata-r8a7791",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee300000 0 0x2000>;
+			reg = <0 0xee300000 0 0x200000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
@@ -1554,7 +1554,7 @@
 		sata1: sata at ee500000 {
 			compatible = "renesas,sata-r8a7791",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee500000 0 0x2000>;
+			reg = <0 0xee500000 0 0x200000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 814>;
 			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-- 
2.11.0
