From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 24 Jan 2014 10:19:01 +0200
Subject: [PATCH 3/9] ARM: DTS: omap4: Set all audio related IP's status to
 disabled as default
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1390551547-12406-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board dts files will need to enable the IP nodes which they are using and
does not have to care about the not used ones (to disable them).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e05853afcd..78c19e30eca0 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -426,6 +426,7 @@
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
+			status = "disabled";
 		};
 
 		dmic: dmic at 4012e000 {
@@ -437,6 +438,7 @@
 			ti,hwmods = "dmic";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
+			status = "disabled";
 		};
 
 		mcbsp1: mcbsp at 40122000 {
@@ -451,6 +453,7 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp2: mcbsp at 40124000 {
@@ -465,6 +468,7 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp3: mcbsp at 40126000 {
@@ -479,6 +483,7 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp4: mcbsp at 48096000 {
@@ -492,6 +497,7 @@
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		keypad: keypad at 4a31c000 {
-- 
1.8.5.3
