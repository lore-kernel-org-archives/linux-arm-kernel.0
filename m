From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:29 +0100
Subject: [PATCH 26/54] arm64: dts: renesas: r8a7795-es1: Point FDP1 via FCPF
 to IPMMU-VP0
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <f54d63fe7ed6d37df15ec8903302dd05375168f4.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the FCPF devices to allow use of FDP1 with IPMMU-VP0.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 6b4dfa42f5b2..736281335653 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -56,6 +56,7 @@
 		clocks = <&cpg CPG_MOD 613>;
 		power-domains = <&sysc R8A7795_PD_A3VP>;
 		resets = <&cpg 613>;
+		iommus = <&ipmmu_vp0 2>;
 	};
 
 	vspi2: vsp at fe9c0000 {
-- 
2.11.0
