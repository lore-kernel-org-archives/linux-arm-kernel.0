From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:49 +0900
Subject: [PATCH 18/30] ARM: shmobile: r8a7779: Use MSTP for SCIF clocks
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <631324cf83a04cbfcc81a21801f321679493a072.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up MSTP clocks to SCIF devices on r8a7779 to allow
clock gating to work as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index ee3bb3e..d9e1abf 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -200,7 +200,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -209,7 +209,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -218,7 +218,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -227,7 +227,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -236,7 +236,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -245,7 +245,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
-- 
2.1.3
