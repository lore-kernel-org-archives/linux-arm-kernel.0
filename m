From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:34:45 +0100
Subject: [PATCH v4 08/15] arm64: dts: renesas: r8a7795-es1: Point FDP1 via
 FCPF to IPMMU-VP0
In-Reply-To: <20171101103452.7491-1-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
Message-ID: <20171101103452.7491-9-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the FCPF devices to allow use of FDP1 with IPMMU-VP0.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v4 [Simon Horman]
* broke out of larger patch

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 451072397601..e90bb26e4f05 100644
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
