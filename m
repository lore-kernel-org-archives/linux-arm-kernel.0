From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 21 Oct 2013 12:45:58 +0300
Subject: [PATCH] ARM: dts: am4372: Add McASP nodes
Message-ID: <1382348758-1083-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for McASP0 and McASP1 for AM43xx.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c328d5c..defaad1 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -633,5 +633,32 @@
 			dma-names = "tx", "rx";
 		};
 
+		mcasp0: mcasp at 48038000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			ti,hwmods = "mcasp0";
+			reg = <0x48038000 0x2000>,
+			      <0x46000000 0x400000>;
+			reg-names = "mpu", "dat";
+			interrupts = <80>, <81>;
+			interrupts-names = "tx", "rx";
+			status = "disabled";
+			dmas = <&edma 8>,
+			       <&edma 9>;
+			dma-names = "tx", "rx";
+		};
+
+		mcasp1: mcasp at 4803C000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			ti,hwmods = "mcasp1";
+			reg = <0x4803C000 0x2000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dat";
+			interrupts = <82>, <83>;
+			interrupts-names = "tx", "rx";
+			status = "disabled";
+			dmas = <&edma 10>,
+			       <&edma 11>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
1.8.4
