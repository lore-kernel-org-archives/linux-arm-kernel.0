From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 6 Jul 2012 17:30:30 -0300
Subject: [PATCH] ARM: dts: imx: Always enable the watchdog
Message-ID: <1341606630-26905-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of enabling the watchdog in each individual dts file, select in 
the SoC dtsi file instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27.dtsi        |    2 +-
 arch/arm/boot/dts/imx51-babbage.dts |    4 ----
 arch/arm/boot/dts/imx51.dtsi        |    2 +-
 arch/arm/boot/dts/imx53-ard.dts     |    4 ----
 arch/arm/boot/dts/imx53-evk.dts     |    4 ----
 arch/arm/boot/dts/imx53-qsb.dts     |    4 ----
 arch/arm/boot/dts/imx53-smd.dts     |    4 ----
 arch/arm/boot/dts/imx53.dtsi        |    2 +-
 arch/arm/boot/dts/imx6q.dtsi        |    2 +-
 9 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 386c769..cd1a7b9 100644
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
index 39eb88e..d33a729 100644
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
index 2b5caf9..bec859a 100644
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
index 8c90cba..6017b3d 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -338,7 +338,7 @@
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 0x04>;
-				status = "disabled";
+				status = "okay";
 			};
 
 			wdog at 020c0000 { /* WDOG2 */
-- 
1.7.1
