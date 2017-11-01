From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:34:47 +0100
Subject: [PATCH v4 10/15] arm64: dts: renesas: r8a7795: Point VSPI via FCPVI
 to IPMMU-VP0/1
In-Reply-To: <20171101103452.7491-1-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
Message-ID: <20171101103452.7491-11-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the FCPVI devices to allow use of VSPI with
IPMMU-VP0 and IPMMU-VP1.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v4 [Simon Horman]
* broke out of larger patch
* Use IPMMU-VP1 for FCPVI1 on ES2.0

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 4 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index bfa2ad20a357..71cc74c54933 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -155,6 +155,10 @@
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
index d5db080678de..ce6188a140b7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2102,6 +2102,7 @@
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 			resets = <&cpg 611>;
+			iommus = <&ipmmu_vp0 8>;
 		};
 
 		vspi1: vsp at fe9b0000 {
@@ -2121,6 +2122,7 @@
 			clocks = <&cpg CPG_MOD 610>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 			resets = <&cpg 610>;
+			iommus = <&ipmmu_vp1 9>;
 		};
 
 		vspd0: vsp at fea20000 {
-- 
2.11.0
