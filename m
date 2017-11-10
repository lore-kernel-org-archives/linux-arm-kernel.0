From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:26:09 +0100
Subject: [PATCH v2 4/7] arm64: dts: renesas: r8a7796: Point FDP1 via FCPF to
 IPMMU-VI0
In-Reply-To: <20171110132612.1589-1-horms+renesas@verge.net.au>
References: <20171110132612.1589-1-horms+renesas@verge.net.au>
Message-ID: <20171110132612.1589-5-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the FCPF devices to allow use of FDP1 with IPMMU-VI0.

Based on work by Magnus Damm for the r8a7795.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2
* Added reviewed by tag from Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 8a67177cccd6..efb80c554ad6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1902,6 +1902,7 @@
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
 		};
 
 		vspd1: vsp at fea28000 {
@@ -1921,6 +1922,7 @@
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
 		};
 
 		vspd2: vsp at fea30000 {
@@ -1940,6 +1942,7 @@
 			clocks = <&cpg CPG_MOD 601>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 601>;
+			iommus = <&ipmmu_vi0 10>;
 		};
 
 		hdmi0: hdmi at fead0000 {
-- 
2.11.0
