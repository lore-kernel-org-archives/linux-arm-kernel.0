From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 16 Jun 2016 18:35:03 -0500
Subject: [PATCH 1/2] arm64: dts: ls1043a: Add cache nodes for cacheinfo support
Message-ID: <1466120104-12023-1-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the cache nodes and next-level-cache property for the
cacheinfo to work.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index de0323b..2b4aa2a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -65,6 +65,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu1: cpu at 1 {
@@ -72,6 +73,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu2: cpu at 2 {
@@ -79,6 +81,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu3: cpu at 3 {
@@ -86,6 +89,11 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
 		};
 	};
 
-- 
1.9.0
