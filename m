From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 16 Jun 2016 18:35:04 -0500
Subject: [PATCH 2/2] arm64: dts: ls2080a: Add cache nodes for cacheinfo support
In-Reply-To: <1466120104-12023-1-git-send-email-leoyang.li@nxp.com>
References: <1466120104-12023-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <1466120104-12023-2-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the cache nodes and next-level-cache property for the
cacheinfo to work.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 3187c82..0f4b9c1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -67,6 +67,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x0>;
 			clocks = <&clockgen 1 0>;
+			next-level-cache = <&cluster0_l2>;
 		};
 
 		cpu at 1 {
@@ -74,6 +75,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x1>;
 			clocks = <&clockgen 1 0>;
+			next-level-cache = <&cluster0_l2>;
 		};
 
 		cpu at 100 {
@@ -81,6 +83,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x100>;
 			clocks = <&clockgen 1 1>;
+			next-level-cache = <&cluster1_l2>;
 		};
 
 		cpu at 101 {
@@ -88,6 +91,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x101>;
 			clocks = <&clockgen 1 1>;
+			next-level-cache = <&cluster1_l2>;
 		};
 
 		cpu at 200 {
@@ -95,6 +99,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x200>;
 			clocks = <&clockgen 1 2>;
+			next-level-cache = <&cluster2_l2>;
 		};
 
 		cpu at 201 {
@@ -102,6 +107,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x201>;
 			clocks = <&clockgen 1 2>;
+			next-level-cache = <&cluster2_l2>;
 		};
 
 		cpu at 300 {
@@ -109,6 +115,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x300>;
 			clocks = <&clockgen 1 3>;
+			next-level-cache = <&cluster3_l2>;
 		};
 
 		cpu at 301 {
@@ -116,6 +123,23 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x301>;
 			clocks = <&clockgen 1 3>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible = "cache";
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible = "cache";
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible = "cache";
 		};
 	};
 
-- 
1.9.0
