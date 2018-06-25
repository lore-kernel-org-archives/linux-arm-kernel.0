From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:19 +0200
Subject: [PATCH 24/29] arm64: dts: renesas: Fix VSPD registers range
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <e21adc781bb45e810f1c396c4bc2c1624a4c25b9.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The VSPD and FCPVD nodes have overlapping register ranges, as the FCPVD
devices are mapped in the memory range usually used by the VSP LUT and
CLU, which are not present in the VSPD. Fix this by shortening the VSPD
registers range to 0x5000.

Fixes: 9f8573e38a0b ("arm64: dts: renesas: r8a7795: Add VSP instances")
Fixes: 291e0c4994d0 ("arm64: dts: r8a7795: Add support for R-Car H3 ES2.0")
Fixes: f06ffdfbdd90 ("arm64: dts: r8a7796: Add VSP instances")
Fixes: b4f92030d5d3 ("arm64: dts: renesas: r8a77970: add VSPD support")
Fixes: 295952a183d3 ("arm64: dts: renesas: r8a77995: add VSP instances")
Fixes: 85cb3229218a ("arm64: dts: renesas: r8a77965: Add VSP instances")
Reported-by: Simon Horman <horms+renesas@verge.net.au>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 6 +++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi     | 6 +++---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi    | 4 ++--
 arch/arm64/boot/dts/renesas/r8a77970.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi    | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index fde3e84626d7..7b2fbaec9aef 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -77,7 +77,7 @@
 
 	vspd3: vsp at fea38000 {
 		compatible = "renesas,vsp2";
-		reg = <0 0xfea38000 0 0x8000>;
+		reg = <0 0xfea38000 0 0x5000>;
 		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 620>;
 		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 018507d78132..e07546f91dff 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2536,7 +2536,7 @@
 
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2547,7 +2547,7 @@
 
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2558,7 +2558,7 @@
 
 		vspd2: vsp at fea30000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea30000 0 0x8000>;
+			reg = <0 0xfea30000 0 0x5000>;
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 6436e814268a..af8196281b06 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2253,7 +2253,7 @@
 
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
@@ -2264,7 +2264,7 @@
 
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
@@ -2275,7 +2275,7 @@
 
 		vspd2: vsp at fea30000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea30000 0 0x8000>;
+			reg = <0 0xfea30000 0 0x5000>;
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index d740c79752d5..a584dfc78339 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1490,7 +1490,7 @@
 
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
@@ -1509,7 +1509,7 @@
 
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 04953e1e205e..954168858fed 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -773,7 +773,7 @@
 
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index b67d38cc4cf0..1de6ffca4772 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -711,7 +711,7 @@
 
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
@@ -721,7 +721,7 @@
 
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-- 
2.11.0
