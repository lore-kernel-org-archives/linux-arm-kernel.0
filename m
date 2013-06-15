From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 15 Jun 2013 16:22:58 +0400
Subject: [PATCH] ARM: dts: imx27: Add VPU devicetree node
Message-ID: <1371298978-23617-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing VPU devicetree node for i.MX27 CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 7017bfe..4dd0c90 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -299,6 +299,21 @@
 			reg = <0x10020000 0x20000>;
 			ranges;
 
+			coda: coda at 10023000 {
+				compatible = "fsl,imx27-vpu";
+				reg = <0x10023000 0x0200>;
+				interrupts = <53>;
+				clocks = <&clks 57>, <&clks 66>;
+				clock-names = "per", "ahb";
+				iram = <&iram>;
+			};
+
+			clks: ccm at 10027000{
+				compatible = "fsl,imx27-ccm";
+				reg = <0x10027000 0x1000>;
+				#clock-cells = <1>;
+			};
+
 			fec: ethernet at 1002b000 {
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
@@ -307,19 +322,16 @@
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
-
-			clks: ccm at 10027000{
-				compatible = "fsl,imx27-ccm";
-				reg = <0x10027000 0x1000>;
-				#clock-cells = <1>;
-			};
 		};
 
+		iram: iram at ffff4c00 {
+			compatible = "mmio-sram";
+			reg = <0xffff4c00 0xb400>;
+		};
 
 		nfc: nand at d8000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-
 			compatible = "fsl,imx27-nand";
 			reg = <0xd8000000 0x1000>;
 			interrupts = <29>;
-- 
1.8.1.5
