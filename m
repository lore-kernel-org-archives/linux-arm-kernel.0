From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:31 +0100
Subject: [PATCH 28/54] arm64: dts: renesas: r8a7795: Point VSPI via FCPVI to
 IPMMU-VP0/1
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <a02aac487325b5bba09a7fd48569d36eb2394a51.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the FCPVI devices to allow use of VSPI with
IPMMU-VP0 and IPMMU-VP1.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 4 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 3d50627c0670..b2d2f04c5e1c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -159,6 +159,10 @@
 	iommus = <&ipmmu_vp0 1>;
 };
 
+&fcpvi1 {
+	iommus = <&ipmmu_vp0 9>;
+};
+
 &fcpvd2 {
 	iommus = <&ipmmu_vi0 10>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 35efacd1ec21..10c7728d1b25 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2120,6 +2120,7 @@
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 			resets = <&cpg 611>;
+			iommus = <&ipmmu_vp0 8>;
 		};
 
 		vspi1: vsp at fe9b0000 {
@@ -2139,6 +2140,7 @@
 			clocks = <&cpg CPG_MOD 610>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 			resets = <&cpg 610>;
+			iommus = <&ipmmu_vp1 9>;
 		};
 
 		vspd0: vsp at fea20000 {
-- 
2.11.0
