From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:34:42 +0100
Subject: [PATCH v4 05/15] arm64: dts: renesas: r8a7795: Point DU/VSPD via
 FCPVD to IPMMU-VI0/1
In-Reply-To: <20171101103452.7491-1-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
Message-ID: <20171101103452.7491-6-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the FCPVD devices to allow use of the VSP and DU
together with IPMMU-VI1 and IPMMU-VI1.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v4 [Simon Horman]
* Broke out of a larger patch
* Use IPMMU-VI1 for fcpvd2 on ES2.0
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 4 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 911fa315d4b2..10e6e71039be 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -145,6 +145,10 @@
 	       <&ipmmu_mp1 30>, <&ipmmu_mp1 31>;
 };
 
+&fcpvd2 {
+	iommus = <&ipmmu_vi0 10>;
+};
+
 &du {
 	vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index eca8db400aff..7addd5ea07e0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2136,6 +2136,7 @@
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
 		};
 
 		vspd1: vsp at fea28000 {
@@ -2155,6 +2156,7 @@
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
 		};
 
 		vspd2: vsp at fea30000 {
@@ -2174,6 +2176,7 @@
 			clocks = <&cpg CPG_MOD 601>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 601>;
+			iommus = <&ipmmu_vi1 10>;
 		};
 
 		fdp1 at fe940000 {
-- 
2.11.0
