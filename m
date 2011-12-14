From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Dec 2011 09:26:45 +0800
Subject: [PATCH V3 2/4] dts/imx: rename uart labels to consistent with hw spec
In-Reply-To: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323826007-17937-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART1/UART2/... is more readable than UART0/UART1/... .
Remove redundant UART comments.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx51-babbage.dts   |    6 +++---
 arch/arm/boot/dts/imx51.dtsi          |   12 ++++++------
 arch/arm/boot/dts/imx53-ard.dts       |    2 +-
 arch/arm/boot/dts/imx53-evk.dts       |    2 +-
 arch/arm/boot/dts/imx53-qsb.dts       |    2 +-
 arch/arm/boot/dts/imx53-smd.dts       |    6 +++---
 arch/arm/boot/dts/imx53.dtsi          |   18 +++++++++---------
 arch/arm/boot/dts/imx6q-sabreauto.dts |    2 +-
 arch/arm/boot/dts/imx6q.dtsi          |   20 ++++++++++----------
 9 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index ed09dc1..564cb8c 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -40,7 +40,7 @@
 					status = "okay";
 				};
 
-				uart2: uart at 7000c000 { /* UART3 */
+				uart3: uart at 7000c000 {
 					fsl,uart-has-rtscts;
 					status = "okay";
 				};
@@ -90,12 +90,12 @@
 				reg = <0x73fa8000 0x4000>;
 			};
 
-			uart0: uart at 73fbc000 {
+			uart1: uart at 73fbc000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-			uart1: uart at 73fc0000 {
+			uart2: uart at 73fc0000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 57a790d..6663986 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -14,9 +14,9 @@
 
 / {
 	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
 	};
 
 	tzic: tz-interrupt-controller at e0000000 {
@@ -86,7 +86,7 @@
 					status = "disabled";
 				};
 
-				uart2: uart at 7000c000 { /* UART3 */
+				uart3: uart at 7000c000 {
 					compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 					reg = <0x7000c000 0x4000>;
 					interrupts = <33>;
@@ -171,14 +171,14 @@
 				status = "disabled";
 			};
 
-			uart0: uart at 73fbc000 {
+			uart1: uart at 73fbc000 {
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fbc000 0x4000>;
 				interrupts = <31>;
 				status = "disabled";
 			};
 
-			uart1: uart at 73fc0000 {
+			uart2: uart at 73fc0000 {
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fc0000 0x4000>;
 				interrupts = <32>;
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 78c949e..2dccce4 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -44,7 +44,7 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart0: uart at 53fbc000 { /* UART1 */
+			uart1: uart at 53fbc000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 964743e..5bac4aa 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -75,7 +75,7 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart0: uart at 53fbc000 { /* UART1 */
+			uart1: uart at 53fbc000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index cc43bde..5c57c86 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -49,7 +49,7 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart0: uart at 53fbc000 { /* UART1 */
+			uart1: uart at 53fbc000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 9e51bc3..c7ee86c 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -39,7 +39,7 @@
 					status = "okay";
 				};
 
-				uart2: uart at 5000c000 { /* UART3 */
+				uart3: uart at 5000c000 {
 					fsl,uart-has-rtscts;
 					status = "okay";
 				};
@@ -90,11 +90,11 @@
 				reg = <0x53fa8000 0x4000>;
 			};
 
-			uart0: uart at 53fbc000 { /* UART1 */
+			uart1: uart at 53fbc000 {
 				status = "okay";
 			};
 
-			uart1: uart at 53fc0000 { /* UART2 */
+			uart2: uart at 53fc0000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 3b15cdc..c10dc1f 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -14,11 +14,11 @@
 
 / {
 	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
 	};
 
 	tzic: tz-interrupt-controller at 0fffc000 {
@@ -173,14 +173,14 @@
 				status = "disabled";
 			};
 
-			uart0: uart at 53fbc000 { /* UART1 */
+			uart1: uart at 53fbc000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <31>;
 				status = "disabled";
 			};
 
-			uart1: uart at 53fc0000 { /* UART2 */
+			uart2: uart at 53fc0000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fc0000 0x4000>;
 				interrupts = <32>;
@@ -226,7 +226,7 @@
 				status = "disabled";
 			};
 
-			uart3: uart at 53ff0000 { /* UART4 */
+			uart4: uart at 53ff0000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <13>;
@@ -241,7 +241,7 @@
 			reg = <0x60000000 0x10000000>;
 			ranges;
 
-			uart4: uart at 63f90000 { /* UART5 */
+			uart5: uart at 63f90000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x63f90000 0x4000>;
 				interrupts = <86>;
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index cd11ab0..eef6d64 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -44,7 +44,7 @@
 				status = "okay";
 			};
 
-			uart3: uart at 021f0000 { /* UART4 */
+			uart4: uart at 021f0000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 9d0bf4b..263e8f3 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -14,11 +14,11 @@
 
 / {
 	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
 	};
 
 	cpus {
@@ -165,7 +165,7 @@
 					status = "disabled";
 				};
 
-				uart0: uart at 02020000 { /* UART1 */
+				uart1: uart at 02020000 {
 					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 0x04>;
@@ -543,28 +543,28 @@
 				interrupts = <0 18 0x04>;
 			};
 
-			uart1: uart at 021e8000 { /* UART2 */
+			uart2: uart at 021e8000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021e8000 0x4000>;
 				interrupts = <0 27 0x04>;
 				status = "disabled";
 			};
 
-			uart2: uart at 021ec000 { /* UART3 */
+			uart3: uart at 021ec000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021ec000 0x4000>;
 				interrupts = <0 28 0x04>;
 				status = "disabled";
 			};
 
-			uart3: uart at 021f0000 { /* UART4 */
+			uart4: uart at 021f0000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f0000 0x4000>;
 				interrupts = <0 29 0x04>;
 				status = "disabled";
 			};
 
-			uart4: uart at 021f4000 { /* UART5 */
+			uart5: uart at 021f4000 {
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f4000 0x4000>;
 				interrupts = <0 30 0x04>;
-- 
1.7.5.4
