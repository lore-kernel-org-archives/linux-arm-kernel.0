From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:25:21 +0100
Subject: [PATCH v5 04/15] arm64: dts: renesas: r8a7795: Tie Audio-DMAC to
 IPMMU-MP0/1
In-Reply-To: <20171110132532.1202-1-horms+renesas@verge.net.au>
References: <20171110132532.1202-1-horms+renesas@verge.net.au>
Message-ID: <20171110132532.1202-5-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up r8a7795 ES2.0 Audio-DMAC nodes to the IPMMU-MP0.
Hook up r8a7795 ES1.x Audio-DMAC nodes to the IPMMU-MP1.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5 [Simon Horman]
* Added reviewed by tag from Geert Uytterhoeven

v4 [Simon Horman]
* Broke out of larger patch
* Use IPMMU-MP0 rather than IPMMU-MP1 for ES2.0
* Added reviewed by tag from Laurent Pinchart

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 38b7cfb3b428..2dfe8108072c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -127,6 +127,28 @@
 	renesas,ipmmu-main = <&ipmmu_mm 7>;
 };
 
+&audma0 {
+	iommus = <&ipmmu_mp1 0>, <&ipmmu_mp1 1>,
+	       <&ipmmu_mp1 2>, <&ipmmu_mp1 3>,
+	       <&ipmmu_mp1 4>, <&ipmmu_mp1 5>,
+	       <&ipmmu_mp1 6>, <&ipmmu_mp1 7>,
+	       <&ipmmu_mp1 8>, <&ipmmu_mp1 9>,
+	       <&ipmmu_mp1 10>, <&ipmmu_mp1 11>,
+	       <&ipmmu_mp1 12>, <&ipmmu_mp1 13>,
+	       <&ipmmu_mp1 14>, <&ipmmu_mp1 15>;
+};
+
+&audma1 {
+	iommus = <&ipmmu_mp1 16>, <&ipmmu_mp1 17>,
+	       <&ipmmu_mp1 18>, <&ipmmu_mp1 19>,
+	       <&ipmmu_mp1 20>, <&ipmmu_mp1 21>,
+	       <&ipmmu_mp1 22>, <&ipmmu_mp1 23>,
+	       <&ipmmu_mp1 24>, <&ipmmu_mp1 25>,
+	       <&ipmmu_mp1 26>, <&ipmmu_mp1 27>,
+	       <&ipmmu_mp1 28>, <&ipmmu_mp1 29>,
+	       <&ipmmu_mp1 30>, <&ipmmu_mp1 31>;
+};
+
 &du {
 	vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index bff0e3a3e582..b13176feec89 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -724,6 +724,14 @@
 			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp0 0>, <&ipmmu_mp0 1>,
+			       <&ipmmu_mp0 2>, <&ipmmu_mp0 3>,
+			       <&ipmmu_mp0 4>, <&ipmmu_mp0 5>,
+			       <&ipmmu_mp0 6>, <&ipmmu_mp0 7>,
+			       <&ipmmu_mp0 8>, <&ipmmu_mp0 9>,
+			       <&ipmmu_mp0 10>, <&ipmmu_mp0 11>,
+			       <&ipmmu_mp0 12>, <&ipmmu_mp0 13>,
+			       <&ipmmu_mp0 14>, <&ipmmu_mp0 15>;
 		};
 
 		audma1: dma-controller at ec720000 {
@@ -758,6 +766,14 @@
 			resets = <&cpg 501>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp0 16>, <&ipmmu_mp0 17>,
+			       <&ipmmu_mp0 18>, <&ipmmu_mp0 19>,
+			       <&ipmmu_mp0 20>, <&ipmmu_mp0 21>,
+			       <&ipmmu_mp0 22>, <&ipmmu_mp0 23>,
+			       <&ipmmu_mp0 24>, <&ipmmu_mp0 25>,
+			       <&ipmmu_mp0 26>, <&ipmmu_mp0 27>,
+			       <&ipmmu_mp0 28>, <&ipmmu_mp0 29>,
+			       <&ipmmu_mp0 30>, <&ipmmu_mp0 31>;
 		};
 
 		avb: ethernet at e6800000 {
-- 
2.11.0
