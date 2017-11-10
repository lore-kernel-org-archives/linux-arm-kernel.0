From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:26:08 +0100
Subject: [PATCH v2 3/7] arm64: dts: renesas: r8a7796: Tie Audio-DMAC to
 IPMMU-MP
In-Reply-To: <20171110132612.1589-1-horms+renesas@verge.net.au>
References: <20171110132612.1589-1-horms+renesas@verge.net.au>
Message-ID: <20171110132612.1589-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up r8a7796 Audio-DMAC nodes to the IPMMU-MP.

Based on work for the r8a7795 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2
* Added reviewed by tag from Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 8ae481504dd4..8a67177cccd6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1326,6 +1326,14 @@
 			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp 0>, <&ipmmu_mp 1>,
+			       <&ipmmu_mp 2>, <&ipmmu_mp 3>,
+			       <&ipmmu_mp 4>, <&ipmmu_mp 5>,
+			       <&ipmmu_mp 6>, <&ipmmu_mp 7>,
+			       <&ipmmu_mp 8>, <&ipmmu_mp 9>,
+			       <&ipmmu_mp 10>, <&ipmmu_mp 11>,
+			       <&ipmmu_mp 12>, <&ipmmu_mp 13>,
+			       <&ipmmu_mp 14>, <&ipmmu_mp 15>;
 		};
 
 		audma1: dma-controller at ec720000 {
@@ -1360,6 +1368,14 @@
 			resets = <&cpg 501>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp 16>, <&ipmmu_mp 17>,
+			       <&ipmmu_mp 18>, <&ipmmu_mp 19>,
+			       <&ipmmu_mp 20>, <&ipmmu_mp 21>,
+			       <&ipmmu_mp 22>, <&ipmmu_mp 23>,
+			       <&ipmmu_mp 24>, <&ipmmu_mp 25>,
+			       <&ipmmu_mp 26>, <&ipmmu_mp 27>,
+			       <&ipmmu_mp 28>, <&ipmmu_mp 29>,
+			       <&ipmmu_mp 30>, <&ipmmu_mp 31>;
 		};
 
 		usb_dmac0: dma-controller at e65a0000 {
-- 
2.11.0
