From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:32 +0100
Subject: [PATCH 29/54] arm64: dts: renesas: r8a7795-es1: Point VSPI via FCPVI
 to IPMMU-VP
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <8f0940b0330c67ed8d6e7dad1210f9b519967ca0.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the FCPVI devices to allow use of VSPI with IPMMU-VP.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index b2d2f04c5e1c..6713eeeab52a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -76,6 +76,7 @@
 		clocks = <&cpg CPG_MOD 609>;
 		power-domains = <&sysc R8A7795_PD_A3VP>;
 		resets = <&cpg 609>;
+		iommus = <&ipmmu_vp0 10>;
 	};
 
 	vspd3: vsp at fea38000 {
-- 
2.11.0
