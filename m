From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 24 Jan 2014 10:19:04 +0200
Subject: [PATCH 6/9] ARM: DTS: omap5: Set all audio related IP's status to
 disabled as default
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1390551547-12406-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board dts files will need to enable the IP nodes which they are using and
does not have to care about the not used ones (to disable them).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad563861..84cee44f1fad 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -467,6 +467,7 @@
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
+			status = "disabled";
 		};
 
 		dmic: dmic at 4012e000 {
@@ -478,6 +479,7 @@
 			ti,hwmods = "dmic";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
+			status = "disabled";
 		};
 
 		mcbsp1: mcbsp at 40122000 {
@@ -492,6 +494,7 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp2: mcbsp at 40124000 {
@@ -506,6 +509,7 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp3: mcbsp at 40126000 {
@@ -520,6 +524,7 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		timer1: timer at 4ae18000 {
-- 
1.8.5.3
