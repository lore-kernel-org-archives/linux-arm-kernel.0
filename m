From: peda@axentia.se (Peter Rosin)
Date: Wed, 21 Mar 2018 16:35:50 +0100
Subject: [PATCH 1/3] ARM: dts: at91: fixes uart pinctrl, set pullup on rx,
 clear pullup on tx
In-Reply-To: <20180321153552.29213-1-peda@axentia.se>
References: <20180321153552.29213-1-peda@axentia.se>
Message-ID: <20180321153552.29213-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove pullup on uart TX signals, they are push-pull outputs thus
pullups are pointless.

Add pullup on uart RX signals, they prevent the RX signals to be left
floating and so consuming a useless extra amount of power in crowbarred
state if nothing is connected to RX.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91rm9200.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9260.dtsi       | 20 ++++++++++----------
 arch/arm/boot/dts/at91sam9261.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9263.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9g45.dtsi       | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9n12.dtsi       |  4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  4 ++--
 arch/arm/boot/dts/sama5d3.dtsi           | 24 ++++++++++++------------
 arch/arm/boot/dts/sama5d3_uart.dtsi      |  8 ++++----
 arch/arm/boot/dts/sama5d4.dtsi           | 28 ++++++++++++++--------------
 12 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index ba61893a02a0..3f3149c156a8 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -511,8 +511,8 @@
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB20 periph A with pullup */
-							 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB21 periph A */
+							<AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_uart1_rts: uart1_rts-0 {
@@ -545,8 +545,8 @@
 				uart2 {
 					pinctrl_uart2: uart2-0 {
 						atmel,pins =
-							<AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA22 periph A */
-							 AT91_PIOA 23 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA23 periph A with pullup */
+							<AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOA 23 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 
 					pinctrl_uart2_rts: uart2_rts-0 {
@@ -563,8 +563,8 @@
 				uart3 {
 					pinctrl_uart3: uart3-0 {
 						atmel,pins =
-							<AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* PA5 periph B with pullup */
-							 AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA6 periph B */
+							<AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_uart3_rts: uart3_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 655f06cd716a..3ae7e6c55fe4 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -468,8 +468,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB6 periph A with pullup */
-							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB7 periph A */
+							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -486,8 +486,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB8 periph A with pullup */
-							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB9 periph A */
+							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -504,8 +504,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB10 periph A with pullup */
-							 AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB11 periph A */
+							<AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
@@ -522,16 +522,16 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* PA31 periph B with pullup */
-							 AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA30 periph B */
+							<AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB12 periph A with pullup */
-							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB13 periph A */
+							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index ddfc63b8fd4e..53c63d0a418a 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -328,8 +328,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -346,8 +346,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -364,8 +364,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index f2405671e3bd..87fb0660ab5d 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -437,8 +437,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA26 periph A with pullup */
-							 AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA27 periph A */
+							<AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -455,8 +455,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD0 periph A with pullup */
-							 AT91_PIOD 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD1 periph A */
+							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -473,8 +473,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD2 periph A with pullup */
-							 AT91_PIOD 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD3 periph A */
+							<AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 3 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 3a30eec7f508..1ee25a475be8 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -555,8 +555,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB19 periph A with pullup */
-							 AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB18 periph A */
+							<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -573,8 +573,8 @@
 				uart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB4 periph A with pullup */
-							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB5 periph A */
+							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -591,8 +591,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB6 periph A with pullup */
-							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB7 periph A */
+							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -609,8 +609,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB9 periph A with pullup */
-							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB8 periph A */
+							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 4b62f4f963f6..37cb81f457b5 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -641,8 +641,8 @@
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOC 16 AT91_PERIPH_C AT91_PINCTRL_PULL_UP	/* PC17 periph C with pullup */
-							 AT91_PIOC 17 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC16 periph C */
+							<AT91_PIOC 16 AT91_PERIPH_C AT91_PINCTRL_NONE
+							 AT91_PIOC 17 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 3cae687dccbd..512337e46f91 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -719,8 +719,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOA 12 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOA 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -742,8 +742,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -765,8 +765,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index fee4fe51a97e..a3c3c3128148 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -520,8 +520,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA0 periph A with pullup */
-							 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA1 periph A */
+							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -543,8 +543,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOA 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA5 periph A with pullup */
-							 AT91_PIOA 6 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA6 periph A */
+							<AT91_PIOA 5 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -566,8 +566,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOA 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA7 periph A with pullup */
-							 AT91_PIOA 8 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA8 periph A */
+							<AT91_PIOA 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
index 43bb5b51caa6..a32d12b406a3 100644
--- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
@@ -21,8 +21,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOC 22 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* PC22 periph B with pullup */
-							 AT91_PIOC 23 AT91_PERIPH_B AT91_PINCTRL_NONE>;		/* PC23 periph B */
+							<AT91_PIOC 22 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOC 23 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index b9c05b57735e..eae5e1ee9cd8 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -861,24 +861,24 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* conflicts with PWMFI2, ISI_D8 */
-							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* conflicts with ISI_PCK */
+							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* conflicts with PWMFI2, ISI_D8 */
+							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* conflicts with ISI_PCK */
 					};
 				};
 
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE	/* conflicts with TWD0, ISI_VSYNC */
-							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* conflicts with TWCK0, ISI_HSYNC */
+							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with TWD0, ISI_VSYNC */
+							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts with TWCK0, ISI_HSYNC */
 					};
 				};
 
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD17 periph A */
-							 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PD18 periph A with pullup */
+							<AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 
 					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
@@ -891,8 +891,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB28 periph A */
-							 AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PB29 periph A with pullup */
+							<AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 
 					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
@@ -905,8 +905,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOE 25 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PE25 periph B, conflicts with A25 */
-							 AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* PE26 periph B with pullup, conflicts NCS0 */
+							<AT91_PIOE 25 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with A25 */
+							 AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts NCS0 */
 					};
 
 					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
@@ -919,8 +919,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOE 18 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PE18 periph B, conflicts with A18 */
-							 AT91_PIOE 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* PE19 periph B with pullup, conflicts with A19 */
+							<AT91_PIOE 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with A18 */
+							 AT91_PIOE 19 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts with A19 */
 					};
 
 					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
index 186377d41c91..f599f8a5f664 100644
--- a/arch/arm/boot/dts/sama5d3_uart.dtsi
+++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
@@ -23,16 +23,16 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PC29 periph A, conflicts with PWMFI2, ISI_D8 */
-							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PC30 periph A with pullup, conflicts with ISI_PCK */
+							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* conflicts with PWMFI2, ISI_D8 */
+							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* conflicts with ISI_PCK */
 					};
 				};
 
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PA30 periph B, conflicts with TWD0, ISI_VSYNC */
-							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* PA31 periph B with pullup, conflicts with TWCK0, ISI_HSYNC */
+							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with TWD0, ISI_VSYNC */
+							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts with TWCK0, ISI_HSYNC */
 					};
 				};
 			};
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 373b3621b536..dfeeaa6e611d 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1926,8 +1926,8 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOE 29 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOE 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOE 29 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOE 30 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 				};
@@ -1935,8 +1935,8 @@
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOC 25 AT91_PERIPH_C AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOC 26 AT91_PERIPH_C AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOC 25 AT91_PERIPH_C AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOC 26 AT91_PERIPH_C AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 				};
@@ -1944,8 +1944,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -1959,8 +1959,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -1974,8 +1974,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOB 4 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD - conflicts with G0_CRS, ISI_HSYNC */
-							 AT91_PIOB 5 AT91_PERIPH_B AT91_PINCTRL_PULL_UP		/* TXD - conflicts with G0_COL, PCK2 */
+							<AT91_PIOB 4 AT91_PERIPH_B AT91_PINCTRL_PULL_UP		/* RXD - conflicts with G0_CRS, ISI_HSYNC */
+							 AT91_PIOB 5 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD - conflicts with G0_COL, PCK2 */
 							>;
 					};
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -1989,8 +1989,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOE 16 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOE 16 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 				};
@@ -1998,8 +1998,8 @@
 				usart4 {
 					pinctrl_usart4: usart4-0 {
 						atmel,pins =
-							<AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOE 27 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOE 27 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 					pinctrl_usart4_rts: usart4_rts-0 {
-- 
2.11.0
