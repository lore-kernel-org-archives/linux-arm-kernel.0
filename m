From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Jul 2016 16:39:45 +0200
Subject: [PATCH 2/8] arm64: dts: r8a7795: Add CAN FD support
In-Reply-To: <cover.1467900241.git.horms+renesas@verge.net.au>
References: <cover.1467900241.git.horms+renesas@verge.net.au>
Message-ID: <162cd7845d5e9e16663079cc589046b3e588c104.1467900241.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Adds CAN FD controller node for r8a7795.

Note: CAN FD controller register base address specified in R-Car Gen3
Hardware User Manual v0.5E is incorrect. The correct address is:

CAN FD - 0xe66c0000

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fad6dd8b7771..b902356873c2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -583,6 +583,30 @@
 			status = "disabled";
 		};
 
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a7795-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+		};
+
 		hscif0: serial at e6540000 {
 			compatible = "renesas,hscif-r8a7795",
 				     "renesas,rcar-gen3-hscif",
-- 
2.7.0.rc3.207.g0ac5344
