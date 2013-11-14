From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 14 Nov 2013 14:02:10 -0700
Subject: [PATCH 4/8] ARM: dts: imx: imx6q.dtsi: use IRQ_TYPE_LEVEL_HIGH
In-Reply-To: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1384462934-17390-5-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the interrupts node slightly more readable.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6q.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 5b92750..101c434 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -8,6 +8,7 @@
  *
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "imx6q-pinfunc.h"
 #include "imx6qdl-pingrp.h"
 #include "imx6qdl.dtsi"
@@ -75,7 +76,7 @@
 					#size-cells = <0>;
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02018000 0x4000>;
-					interrupts = <0 35 0x04>;
+					interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks 116>, <&clks 116>;
 					clock-names = "ipg", "per";
 					status = "disabled";
@@ -126,7 +127,7 @@
 		sata: sata at 02200000 {
 			compatible = "fsl,imx6q-ahci";
 			reg = <0x02200000 0x4000>;
-			interrupts = <0 39 0x04>;
+			interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =  <&clks 154>, <&clks 187>, <&clks 105>;
 			clock-names = "sata", "sata_ref", "ahb";
 			status = "disabled";
@@ -136,7 +137,8 @@
 			#crtc-cells = <1>;
 			compatible = "fsl,imx6q-ipu";
 			reg = <0x02800000 0x400000>;
-			interrupts = <0 8 0x4 0 7 0x4>;
+			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
-- 
1.8.1.2
