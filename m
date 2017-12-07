From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:15 +0100
Subject: [PATCH 12/54] arm64: dts: renesas: r8a7796: Point VSPI via FCPVI to
 IPMMU-VC0
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <cef942d0bd89dc42145f6e55eaad5e710a0c83f8.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the FCPVI devices to allow use of VSPI with IPMMU-VC0.

Based on work for the r8a7795 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 859dde64311e..3b7a727b94be 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1884,6 +1884,7 @@
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A7796_PD_A3VC>;
 			resets = <&cpg 611>;
+			iommus = <&ipmmu_vc0 19>;
 		};
 
 		vspd0: vsp at fea20000 {
-- 
2.11.0
