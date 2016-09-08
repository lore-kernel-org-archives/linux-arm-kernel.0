From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:42:57 +0200
Subject: [PATCH 01/30] arm64: dts: r8a7795: add FCPF device nodes
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <28fc813153a4702cdcad98a2a53b920eb7d66061.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran@ksquared.org.uk>

Provide nodes for the FCP devices dedicated to the FDP device channels.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b902356873c2..8c85b50d306b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1273,5 +1273,26 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
+
+		fcpf0: fcp at fe950000 {
+			compatible = "renesas,r8a7795-fcpf", "renesas,fcpf";
+			reg = <0 0xfe950000 0 0x200>;
+			clocks = <&cpg CPG_MOD 615>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+		};
+
+		fcpf1: fcp at fe951000 {
+			compatible = "renesas,r8a7795-fcpf", "renesas,fcpf";
+			reg = <0 0xfe951000 0 0x200>;
+			clocks = <&cpg CPG_MOD 614>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+		};
+
+		fcpf2: fcp at fe952000 {
+			compatible = "renesas,r8a7795-fcpf", "renesas,fcpf";
+			reg = <0 0xfe952000 0 0x200>;
+			clocks = <&cpg CPG_MOD 613>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+		};
 	};
 };
-- 
2.7.0.rc3.207.g0ac5344
