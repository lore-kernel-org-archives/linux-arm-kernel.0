From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 Jul 2012 16:43:30 -0300
Subject: [PATCH v2] ARM: dts: imx: Always enable the watchdog
Message-ID: <1343504610-2417-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of enabling the watchdog in each individual dts file, select in 
the SoC dtsi file instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Remove the wdog setting in imx27-phytec-phycore.dts
 arch/arm/boot/dts/imx27-phytec-phycore.dts |    4 ----
 arch/arm/boot/dts/imx27.dtsi               |    2 +-
 arch/arm/boot/dts/imx51-babbage.dts        |    4 ----
 arch/arm/boot/dts/imx51.dtsi               |    2 +-
 arch/arm/boot/dts/imx53-ard.dts            |    4 ----
 arch/arm/boot/dts/imx53-evk.dts            |    4 ----
 arch/arm/boot/dts/imx53-qsb.dts            |    4 ----
 arch/arm/boot/dts/imx53-smd.dts            |    4 ----
 arch/arm/boot/dts/imx53.dtsi               |    2 +-
 arch/arm/boot/dts/imx6q.dtsi               |    2 +-
 10 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index 2b0ff60..777caa3 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -23,10 +23,6 @@
 	soc {
 		aipi at 10000000 { /* aipi */
 
-			wdog at 10002000 {
-				status = "okay";
-			};
-
 			serial at 1000a000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 00bae3a..9422187 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -56,7 +56,7 @@
 				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
 				reg = <0x10002000 0x4000>;
 				interrupts = <27>;
-				status = "disabled";
+				status = "okay";
 			};
 
 			uart1: serial at 1000a000 {
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index de065b5..f7caa08 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -169,10 +169,6 @@
 				};
 			};
 
-			wdog at 73f98000 { /* WDOG1 */
-				status = "okay";
-			};
-
 			iomuxc at 73fa8000 {
 				compatible = "fsl,imx51-iomuxc-babbage";
 				reg = <0x73fa8000 0x4000>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 3af176c..974357e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -170,7 +170,7 @@
 				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
 				reg = <0x73f98000 0x4000>;
 				interrupts = <58>;
-				status = "disabled";
+				status = "okay";
 			};
 
 			wdog at 73f9c000 { /* WDOG2 */
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 5b8eafc..1854145 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -31,10 +31,6 @@
 				};
 			};
 
-			wdog at 53f98000 { /* WDOG1 */
-				status = "okay";
-			};
-
 			iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc-ard";
 				reg = <0x53fa8000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 9c79803..5d36dde 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -62,10 +62,6 @@
 				};
 			};
 
-			wdog at 53f98000 { /* WDOG1 */
-				status = "okay";
-			};
-
 			iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc-evk";
 				reg = <0x53fa8000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 2d803a9..3bfa6f1 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -41,10 +41,6 @@
 				};
 			};
 
-			wdog at 53f98000 { /* WDOG1 */
-				status = "okay";
-			};
-
 			iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc-qsb";
 				reg = <0x53fa8000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 0809102..45848af 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -77,10 +77,6 @@
 				};
 			};
 
-			wdog at 53f98000 { /* WDOG1 */
-				status = "okay";
-			};
-
 			iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc-smd";
 				reg = <0x53fa8000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index d161901..4c599f0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -172,7 +172,7 @@
 				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
-				status = "disabled";
+				status = "okay";
 			};
 
 			wdog at 53f9c000 { /* WDOG2 */
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 3d3c64b..085744f 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -355,7 +355,7 @@
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 0x04>;
-				status = "disabled";
+				status = "okay";
 			};
 
 			wdog at 020c0000 { /* WDOG2 */
-- 
1.7.1
