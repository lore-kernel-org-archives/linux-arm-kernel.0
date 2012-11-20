From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:31:42 +0100
Subject: [PATCH 4/5] ARM: at91: fix usart/uart namimg in pinctrl
In-Reply-To: <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121120212326.GO4398@game.jcrosoft.org>
 <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353447103-31616-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USART are the full pin uart
DBGU the debug Unit
UART the two pin uart

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/at91sam9260.dtsi          |   58 +++++++++++++--------------
 arch/arm/boot/dts/at91sam9263.dtsi          |   24 +++++------
 arch/arm/boot/dts/at91sam9263ek.dts         |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   10 ++---
 arch/arm/boot/dts/at91sam9g45.dtsi          |   30 +++++++-------
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |    2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi          |   38 +++++++++---------
 arch/arm/boot/dts/at91sam9x5.dtsi           |   36 ++++++++---------
 8 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 36f55e3..40bf329 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -21,8 +21,8 @@
 		serial2 = &usart1;
 		serial3 = &usart2;
 		serial4 = &usart3;
-		serial5 = &usart4;
-		serial6 = &usart5;
+		serial5 = &uart0;
+		serial6 = &uart1;
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
@@ -120,88 +120,88 @@
 					};
 				};
 
-				uart0 {
-					pinctrl_uart0: uart0-0 {
+				usart0 {
+					pinctrl_usart0: usart0-0 {
 						atmel,pins =
 							<1 4 0x1 0x0	/* PB4 periph A */
 							 1 5 0x1 0x0>;	/* PB5 periph A */
 					};
 
-					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
+					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
 						atmel,pins =
 							<1 26 0x1 0x0	/* PB26 periph A */
 							 1 27 0x1 0x0>;	/* PB27 periph A */
 					};
 
-					pinctrl_uart0_dtr_dsr: uart0_dtr_dsr-0 {
+					pinctrl_usart0_dtr_dsr: usart0_dtr_dsr-0 {
 						atmel,pins =
 							<1 24 0x1 0x0	/* PB24 periph A */
 							 1 22 0x1 0x0>;	/* PB22 periph A */
 					};
 
-					pinctrl_uart0_dcd: uart0_dcd-0 {
+					pinctrl_usart0_dcd: usart0_dcd-0 {
 						atmel,pins =
 							<1 23 0x1 0x0>;	/* PB23 periph A */
 					};
 
-					pinctrl_uart0_ri: uart0_ri-0 {
+					pinctrl_usart0_ri: usart0_ri-0 {
 						atmel,pins =
 							<1 25 0x1 0x0>;	/* PB25 periph A */
 					};
 				};
 
-				uart1 {
-					pinctrl_uart1: uart1-0 {
+				usart1 {
+					pinctrl_usart1: usart1-0 {
 						atmel,pins =
 							<2 6 0x1 0x1	/* PB6 periph A with pullup */
 							 2 7 0x1 0x0>;	/* PB7 periph A */
 					};
 
-					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
+					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
 						atmel,pins =
 							<1 28 0x1 0x0	/* PB28 periph A */
 							 1 29 0x1 0x0>;	/* PB29 periph A */
 					};
 				};
 
-				uart2 {
-					pinctrl_uart2: uart2-0 {
+				usart2 {
+					pinctrl_usart2: usart2-0 {
 						atmel,pins =
 							<1 8 0x1 0x1	/* PB8 periph A with pullup */
 							 1 9 0x1 0x0>;	/* PB9 periph A */
 					};
 
-					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
+					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
 						atmel,pins =
 							<0 4 0x1 0x0	/* PA4 periph A */
 							 0 5 0x1 0x0>;	/* PA5 periph A */
 					};
 				};
 
-				uart3 {
-					pinctrl_uart3: uart3-0 {
+				usart3 {
+					pinctrl_usart3: usart3-0 {
 						atmel,pins =
 							<2 10 0x1 0x1	/* PB10 periph A with pullup */
 							 2 11 0x1 0x0>;	/* PB11 periph A */
 					};
 
-					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
+					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
 						atmel,pins =
 							<3 8 0x2 0x0	/* PB8 periph B */
 							 3 10 0x2 0x0>;	/* PB10 periph B */
 					};
 				};
 
-				uart4 {
-					pinctrl_uart4: uart4-0 {
+				uart0 {
+					pinctrl_uart0: uart0-0 {
 						atmel,pins =
 							<0 31 0x2 0x1	/* PA31 periph B with pullup */
 							 0 30 0x2 0x0>;	/* PA30 periph B */
 					};
 				};
 
-				uart5 {
-					pinctrl_uart5: uart5-0 {
+				uart1 {
+					pinctrl_uart1: uart1-0 {
 						atmel,pins =
 							<2 12 0x1 0x1	/* PB12 periph A with pullup */
 							 2 13 0x1 0x0>;	/* PB13 periph A */
@@ -303,7 +303,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart0>;
+				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
 			};
 
@@ -314,7 +314,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1>;
+				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
 			};
 
@@ -325,7 +325,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2>;
+				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
 			};
 
@@ -336,29 +336,29 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart3>;
+				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
 			};
 
-			usart4: serial at fffd4000 {
+			uart0: serial at fffd4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd4000 0x200>;
 				interrupts = <24 4 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart4>;
+				pinctrl-0 = <&pinctrl_uart0>;
 				status = "disabled";
 			};
 
-			usart5: serial at fffd8000 {
+			uart1: serial at fffd8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd8000 0x200>;
 				interrupts = <25 4 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart5>;
+				pinctrl-0 = <&pinctrl_uart1>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 148b89a..cf4b59f 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -113,42 +113,42 @@
 					};
 				};
 
-				uart0 {
-					pinctrl_uart0: uart0-0 {
+				usart0 {
+					pinctrl_usart0: usart0-0 {
 						atmel,pins =
 							<0 26 0x1 0x1	/* PA26 periph A with pullup */
 							 0 27 0x1 0x0>;	/* PA27 periph A */
 					};
 
-					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
+					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
 						atmel,pins =
 							<0 28 0x1 0x0	/* PA28 periph A */
 							 0 29 0x1 0x0>;	/* PA29 periph A */
 					};
 				};
 
-				uart1 {
-					pinctrl_uart1: uart1-0 {
+				usart1 {
+					pinctrl_usart1: usart1-0 {
 						atmel,pins =
 							<3 0 0x1 0x1	/* PD0 periph A with pullup */
 							 3 1 0x1 0x0>;	/* PD1 periph A */
 					};
 
-					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
+					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
 						atmel,pins =
 							<3 7 0x2 0x0	/* PD7 periph B */
 							 3 8 0x2 0x0>;	/* PD8 periph B */
 					};
 				};
 
-				uart2 {
-					pinctrl_uart2: uart2-0 {
+				usart2 {
+					pinctrl_usart2: usart2-0 {
 						atmel,pins =
 							<3 2 0x1 0x1	/* PD2 periph A with pullup */
 							 3 3 0x1 0x0>;	/* PD3 periph A */
 					};
 
-					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
+					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
 						atmel,pins =
 							<3 5 0x2 0x0	/* PD5 periph B */
 							 4 6 0x2 0x0>;	/* PD6 periph B */
@@ -258,7 +258,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart0>;
+				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
 			};
 
@@ -269,7 +269,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1>;
+				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
 			};
 
@@ -280,7 +280,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2>;
+				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 7cfe9d5..3434373 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -38,7 +38,7 @@
 			};
 
 			usart0: serial at fff8c000 {
-				pinctrl-0 = <&pinctrl_uart0 &pinctrl_uart0_rts_cts>;
+				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts_cts>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index e33ab0a..04f048f 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -36,11 +36,11 @@
 
 			usart0: serial at fffb0000 {
 				pinctrl-0 =
-					<&pinctrl_uart0
-					 &pinctrl_uart0_rts_cts
-					 &pinctrl_uart0_dtr_dsr
-					 &pinctrl_uart0_dcd
-					 &pinctrl_uart0_ri>;
+					<&pinctrl_usart0
+					 &pinctrl_usart0_rts_cts
+					 &pinctrl_usart0_dtr_dsr
+					 &pinctrl_usart0_dcd
+					 &pinctrl_usart0_ri>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 0ad84b6..56ce896 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -132,14 +132,14 @@
 					};
 				};
 
-				uart0 {
-					pinctrl_uart0: uart0-0 {
+				usart0 {
+					pinctrl_usart0: usart0-0 {
 						atmel,pins =
 							<1 19 0x1 0x1	/* PB19 periph A with pullup */
 							 1 18 0x1 0x0>;	/* PB18 periph A */
 					};
 
-					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
+					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
 						atmel,pins =
 							<1 17 0x2 0x0	/* PB17 periph B */
 							 1 15 0x2 0x0>;	/* PB15 periph B */
@@ -147,41 +147,41 @@
 				};
 
 				uart1 {
-					pinctrl_uart1: uart1-0 {
+					pinctrl_usart1: usart1-0 {
 						atmel,pins =
 							<1 4 0x1 0x1	/* PB4 periph A with pullup */
 							 1 5 0x1 0x0>;	/* PB5 periph A */
 					};
 
-					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
+					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
 						atmel,pins =
 							<3 16 0x1 0x0	/* PD16 periph A */
 							 3 17 0x1 0x0>;	/* PD17 periph A */
 					};
 				};
 
-				uart2 {
-					pinctrl_uart2: uart2-0 {
+				usart2 {
+					pinctrl_usart2: usart2-0 {
 						atmel,pins =
 							<1 6 0x1 0x1	/* PB6 periph A with pullup */
 							 1 7 0x1 0x0>;	/* PB7 periph A */
 					};
 
-					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
+					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
 						atmel,pins =
 							<2 9 0x2 0x0	/* PC9 periph B */
 							 2 11 0x2 0x0>;	/* PC11 periph B */
 					};
 				};
 
-				uart3 {
-					pinctrl_uart3: uart3-0 {
+				usart3 {
+					pinctrl_usart3: usart3-0 {
 						atmel,pins =
 							<1 8 0x1 0x1	/* PB9 periph A with pullup */
 							 1 9 0x1 0x0>;	/* PB8 periph A */
 					};
 
-					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
+					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
 						atmel,pins =
 							<0 23 0x2 0x0	/* PA23 periph B */
 							 0 24 0x2 0x0>;	/* PA24 periph B */
@@ -291,7 +291,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart0>;
+				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
 			};
 
@@ -302,7 +302,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1>;
+				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
 			};
 
@@ -313,7 +313,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2>;
+				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
 			};
 
@@ -324,7 +324,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart3>;
+				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 6aa28b9..0d9674b 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -39,7 +39,7 @@
 			};
 
 			usart1: serial at fff90000 {
-				pinctrl-0 = <&pinctrl_uart0 &pinctrl_uart1_rts_cts>;
+				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 7b644c5..10547bc 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -125,66 +125,66 @@
 					};
 				};
 
-				uart0 {
-					pinctrl_uart0: uart0-0 {
+				usart0 {
+					pinctrl_usart0: usart0-0 {
 						atmel,pins =
 							<0 1 0x1 0x1	/* PA1 periph A with pullup */
 							 0 0 0x1 0x0>;	/* PA0 periph A */
 					};
 
-					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
+					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
 						atmel,pins =
 							<0 2 0x1 0x0	/* PA2 periph A */
 							 0 3 0x1 0x0>;	/* PA3 periph A */
 					};
 				};
 
-				uart1 {
-					pinctrl_uart1: uart1-0 {
+				usart1 {
+					pinctrl_usart1: usart1-0 {
 						atmel,pins =
 							<0 6 0x1 0x1	/* PA6 periph A with pullup */
 							 0 5 0x1 0x0>;	/* PA5 periph A */
 					};
 				};
 
-				uart2 {
-					pinctrl_uart2: uart2-0 {
+				usart2 {
+					pinctrl_usart2: usart2-0 {
 						atmel,pins =
 							<0 8 0x1 0x1	/* PA8 periph A with pullup */
 							 0 7 0x1 0x0>;	/* PA7 periph A */
 					};
 
-					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
+					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
 						atmel,pins =
 							<1 0 0x2 0x0	/* PB0 periph B */
 							 1 1 0x2 0x0>;	/* PB1 periph B */
 					};
 				};
 
-				uart3 {
-					pinctrl_uart3: uart3-0 {
+				usart3 {
+					pinctrl_usart3: usart3-0 {
 						atmel,pins =
 							<2 23 0x2 0x1	/* PC23 periph B with pullup */
 							 2 22 0x2 0x0>;	/* PC22 periph B */
 					};
 
-					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
+					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
 						atmel,pins =
 							<2 24 0x2 0x0	/* PC24 periph B */
 							 2 25 0x2 0x0>;	/* PC25 periph B */
 					};
 				};
 
-				usart0 {
-					pinctrl_usart0: usart0-0 {
+				uart0 {
+					pinctrl_uart0: uart0-0 {
 						atmel,pins =
 							<2 9 0x3 0x1	/* PC9 periph C with pullup */
 							 2 8 0x3 0x0>;	/* PC8 periph C */
 					};
 				};
 
-				usart1 {
-					pinctrl_usart1: usart1-0 {
+				uart1 {
+					pinctrl_uart1: uart1-0 {
 						atmel,pins =
 							<2 16 0x3 0x1	/* PC17 periph C with pullup */
 							 2 17 0x3 0x0>;	/* PC16 periph C */
@@ -256,7 +256,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart0>;
+				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
 			};
 
@@ -267,7 +267,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1>;
+				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
 			};
 
@@ -278,7 +278,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2>;
+				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
 			};
 
@@ -289,7 +289,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart3>;
+				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 9fd7159..9dac006 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -126,36 +126,36 @@
 					};
 				};
 
-				uart0 {
-					pinctrl_uart0: uart0-0 {
+				usart0 {
+					pinctrl_usart0: usart0-0 {
 						atmel,pins =
 							<0 0 0x1 0x1	/* PA0 periph A with pullup */
 							 0 1 0x1 0x0>;	/* PA1 periph A */
 					};
 
-					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
+					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
 						atmel,pins =
 							<0 2 0x1 0x0	/* PA2 periph A */
 							 0 3 0x1 0x0>;	/* PA3 periph A */
 					};
 				};
 
-				uart1 {
-					pinctrl_uart1: uart1-0 {
+				usart1 {
+					pinctrl_usart1: usart1-0 {
 						atmel,pins =
 							<0 5 0x1 0x1	/* PA5 periph A with pullup */
 							 0 6 0x1 0x0>;	/* PA6 periph A */
 					};
 
-					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
+					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
 						atmel,pins =
 							<3 27 0x3 0x0	/* PC27 periph C */
 							 3 28 0x3 0x0>;	/* PC28 periph C */
 					};
 				};
 
-				uart2 {
-					pinctrl_uart2: uart2-0 {
+				usart2 {
+					pinctrl_usart2: usart2-0 {
 						atmel,pins =
 							<0 7 0x1 0x1	/* PA7 periph A with pullup */
 							 0 8 0x1 0x0>;	/* PA8 periph A */
@@ -168,30 +168,30 @@
 					};
 				};
 
-				uart3 {
-					pinctrl_uart3: uart3-0 {
+				usart3 {
+					pinctrl_uart3: usart3-0 {
 						atmel,pins =
 							<3 23 0x2 0x1	/* PC22 periph B with pullup */
 							 3 23 0x2 0x0>;	/* PC23 periph B */
 					};
 
-					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
+					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
 						atmel,pins =
 							<3 24 0x2 0x0	/* PC24 periph B */
 							 3 25 0x2 0x0>;	/* PC25 periph B */
 					};
 				};
 
-				usart0 {
-					pinctrl_usart0: usart0-0 {
+				uart0 {
+					pinctrl_uart0: uart0-0 {
 						atmel,pins =
 							<3 8 0x3 0x0	/* PC8 periph C */
 							 3 9 0x3 0x1>;	/* PC9 periph C with pullup */
 					};
 				};
 
-				usart1 {
-					pinctrl_usart1: usart1-0 {
+				uart1 {
+					pinctrl_uart1: uart1-0 {
 						atmel,pins =
 							<3 16 0x3 0x0	/* PC16 periph C */
 							 3 17 0x3 0x1>;	/* PC17 periph C with pullup */
@@ -293,7 +293,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart0>;
+				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
 			};
 
@@ -304,7 +304,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1>;
+				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
 			};
 
@@ -315,7 +315,7 @@
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2>;
+				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
 			};
 
-- 
1.7.10.4
