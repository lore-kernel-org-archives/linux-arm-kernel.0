From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:34:55 +0100
Subject: [PATCH 4/7] arm64: dts: renesas: r8a7796: Point FDP1 via FCPF to
 IPMMU-VI0
In-Reply-To: <20171101103458.7582-1-horms+renesas@verge.net.au>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
Message-ID: <20171101103458.7582-5-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the FCPF devices to allow use of FDP1 with IPMMU-VI0.

Based on work by Magnus Damm for the r8a7795.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index ce74a7ae47f4..d4c2e12daba7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1892,6 +1892,7 @@
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
 		};
 
 		vspd1: vsp at fea28000 {
@@ -1911,6 +1912,7 @@
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
 		};
 
 		vspd2: vsp at fea30000 {
@@ -1930,6 +1932,7 @@
 			clocks = <&cpg CPG_MOD 601>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 601>;
+			iommus = <&ipmmu_vi0 10>;
 		};
 
 		hdmi0: hdmi at fead0000 {
-- 
2.11.0
