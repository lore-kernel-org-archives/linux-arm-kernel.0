From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:25:24 +0100
Subject: [PATCH v5 07/15] arm64: dts: renesas: r8a7795: Point FDP1 via FCPF to
 IPMMU-VP0/1
In-Reply-To: <20171110132532.1202-1-horms+renesas@verge.net.au>
References: <20171110132532.1202-1-horms+renesas@verge.net.au>
Message-ID: <20171110132532.1202-8-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the FCPF devices to allow use of FDP1 with IPMMU-VP.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5 [Simon Horman]
* Added reviewed by tag from Geert Uytterhoeven

v4 [Simon Horman]
* Broke out of larger patch
* Use IPMMU-VP1 for FCPF1 on ES2.0

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 4 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 1eafa5382e86..6b4dfa42f5b2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -150,6 +150,10 @@
 	       <&ipmmu_mp1 30>, <&ipmmu_mp1 31>;
 };
 
+&fcpf1 {
+	iommus = <&ipmmu_vp0 1>;
+};
+
 &fcpvd2 {
 	iommus = <&ipmmu_vi0 10>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index d5e3d208bc37..1202b84104a0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2070,6 +2070,7 @@
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 			resets = <&cpg 615>;
+			iommus = <&ipmmu_vp0 0>;
 		};
 
 		fcpf1: fcp at fe951000 {
@@ -2078,6 +2079,7 @@
 			clocks = <&cpg CPG_MOD 614>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 			resets = <&cpg 614>;
+			iommus = <&ipmmu_vp1 1>;
 		};
 
 		vspbd: vsp at fe960000 {
-- 
2.11.0
