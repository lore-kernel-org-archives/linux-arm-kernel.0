From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 00:33:01 -0300
Subject: [PATCH 1/5] ARM: dts: imx28.dtsi: Add auart support
Message-ID: <1339731185-4889-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add auart support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..f26e0d6 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -22,6 +22,11 @@
 		gpio4 = &gpio4;
 		saif0 = &saif0;
 		saif1 = &saif1;
+		serial0 = &auart0;
+		serial1 = &auart1;
+		serial2 = &auart2;
+		serial3 = &auart3;
+		serial4 = &auart4;
 	};
 
 	cpus {
@@ -167,6 +172,22 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart0_pins_a: auart0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x3000 0x3010 0x3020 0x3030>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				auart3_pins_a: auart3 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x30c0 0x30d0 0x30e0 0x30f0>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <0x4000 0x4010 0x4020
@@ -404,30 +425,35 @@
 			};
 
 			auart0: serial@8006a000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
 				status = "disabled";
 			};
 
 			auart1: serial at 8006c000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x8006c000 0x2000>;
 				interrupts = <113 72 73>;
 				status = "disabled";
 			};
 
 			auart2: serial at 8006e000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x8006e000 0x2000>;
 				interrupts = <114 74 75>;
 				status = "disabled";
 			};
 
 			auart3: serial at 80070000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x80070000 0x2000>;
 				interrupts = <115 76 77>;
 				status = "disabled";
 			};
 
 			auart4: serial at 80072000 {
+				compatible = "fsl,mxs-auart";
 				reg = <0x80072000 0x2000>;
 				interrupts = <116 78 79>;
 				status = "disabled";
-- 
1.7.1
