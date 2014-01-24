From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 24 Jan 2014 10:19:06 +0200
Subject: [PATCH 8/9] ARM: DTS: omap2: Set disabled status for McBSP instances
 as default state
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1390551547-12406-9-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In omap2420.dtsi and omap2430.dtsi disable all mcbsp nodes and board dts
files can explicitly enable the mcbsp they are using.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi | 2 ++
 arch/arm/boot/dts/omap2430.dtsi | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index 60c605de22dd..85b1fb014c43 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -99,6 +99,7 @@
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp2: mcbsp at 48076000 {
@@ -112,6 +113,7 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		msdi1: mmc at 4809c000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index d624345666f5..9d2f028fd687 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -113,6 +113,7 @@
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp2: mcbsp at 48076000 {
@@ -128,6 +129,7 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp3: mcbsp at 4808c000 {
@@ -143,6 +145,7 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp4: mcbsp at 4808e000 {
@@ -158,6 +161,7 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp5: mcbsp at 48096000 {
@@ -173,6 +177,7 @@
 			dmas = <&sdma 21>,
 			       <&sdma 22>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mmc1: mmc at 4809c000 {
-- 
1.8.5.3
