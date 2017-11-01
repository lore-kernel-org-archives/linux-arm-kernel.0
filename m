From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:35:02 +0100
Subject: [PATCH 2/4] arm64: dts: renesas: r8a77970: Tie SYS-DMAC to IPMMU-DS1
In-Reply-To: <20171101103504.7658-1-horms+renesas@verge.net.au>
References: <20171101103504.7658-1-horms+renesas@verge.net.au>
Message-ID: <20171101103504.7658-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up r8a77970 DMAC nodes to the IPMMU. In particular
SYS-DMAC1 and SYS-DMAC2 get tied to IPMMU-DS1.

Based on work for the r8a7796 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index fbae43ff70b2..f60493872089 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -218,6 +218,10 @@
 			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <8>;
+			iommus = <&ipmmu_ds1 0>, <&ipmmu_ds1 1>,
+			       <&ipmmu_ds1 2>, <&ipmmu_ds1 3>,
+			       <&ipmmu_ds1 4>, <&ipmmu_ds1 5>,
+			       <&ipmmu_ds1 6>, <&ipmmu_ds1 7>;
 		};
 
 		dmac2: dma-controller at e7310000 {
@@ -242,6 +246,10 @@
 			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <8>;
+			iommus = <&ipmmu_ds1 16>, <&ipmmu_ds1 17>,
+			       <&ipmmu_ds1 18>, <&ipmmu_ds1 19>,
+			       <&ipmmu_ds1 20>, <&ipmmu_ds1 21>,
+			       <&ipmmu_ds1 22>, <&ipmmu_ds1 23>;
 		};
 
 		hscif0: serial at e6540000 {
-- 
2.11.0
