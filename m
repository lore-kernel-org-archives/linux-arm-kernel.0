From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:31:43 +0100
Subject: [PATCH 5/5] ARM: at91: dt: at91sam9260: split rts and cts pinctrl not
In-Reply-To: <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121120212326.GO4398@game.jcrosoft.org>
 <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353447103-31616-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as we just use the rts and not the rts & cts for rs485

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/at91sam9260.dtsi          |   40 +++++++++++++++++++--------
 arch/arm/boot/dts/at91sam9263.dtsi          |   30 ++++++++++++++------
 arch/arm/boot/dts/at91sam9263ek.dts         |    5 +++-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    3 +-
 arch/arm/boot/dts/at91sam9g45.dtsi          |   40 +++++++++++++++++++--------
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |    5 +++-
 arch/arm/boot/dts/at91sam9n12.dtsi          |   30 ++++++++++++++------
 arch/arm/boot/dts/at91sam9x5.dtsi           |   40 +++++++++++++++++++--------
 8 files changed, 136 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 40bf329..a5d9460 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -127,10 +127,14 @@
 							 1 5 0x1 0x0>;	/* PB5 periph A */
 					};
 
-					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
+					pinctrl_usart0_rts: usart0_rts-0 {
 						atmel,pins =
-							<1 26 0x1 0x0	/* PB26 periph A */
-							 1 27 0x1 0x0>;	/* PB27 periph A */
+							<1 26 0x1 0x0>;	/* PB26 periph A */
+					};
+
+					pinctrl_usart0_cts: usart0_cts-0 {
+						atmel,pins =
+							<1 27 0x1 0x0>;	/* PB27 periph A */
 					};
 
 					pinctrl_usart0_dtr_dsr: usart0_dtr_dsr-0 {
@@ -157,10 +161,14 @@
 							 2 7 0x1 0x0>;	/* PB7 periph A */
 					};
 
-					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
+					pinctrl_usart1_rts: usart1_rts-0 {
+						atmel,pins =
+							<1 28 0x1 0x0>;	/* PB28 periph A */
+					};
+
+					pinctrl_usart1_cts: usart1_cts-0 {
 						atmel,pins =
-							<1 28 0x1 0x0	/* PB28 periph A */
-							 1 29 0x1 0x0>;	/* PB29 periph A */
+							<1 29 0x1 0x0>;	/* PB29 periph A */
 					};
 				};
 
@@ -171,10 +179,14 @@
 							 1 9 0x1 0x0>;	/* PB9 periph A */
 					};
 
-					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
+					pinctrl_usart2_rts: usart2_rts-0 {
 						atmel,pins =
-							<0 4 0x1 0x0	/* PA4 periph A */
-							 0 5 0x1 0x0>;	/* PA5 periph A */
+							<0 4 0x1 0x0>;	/* PA4 periph A */
+					};
+
+					pinctrl_usart2_cts: usart2_cts-0 {
+						atmel,pins =
+							<0 5 0x1 0x0>;	/* PA5 periph A */
 					};
 				};
 
@@ -185,10 +197,14 @@
 							 2 11 0x1 0x0>;	/* PB11 periph A */
 					};
 
-					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
+					pinctrl_usart3_rts: usart3_rts-0 {
+						atmel,pins =
+							<3 8 0x2 0x0>;	/* PB8 periph B */
+					};
+
+					pinctrl_usart3_cts: usart3_cts-0 {
 						atmel,pins =
-							<3 8 0x2 0x0	/* PB8 periph B */
-							 3 10 0x2 0x0>;	/* PB10 periph B */
+							<3 10 0x2 0x0>;	/* PB10 periph B */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index cf4b59f..a14aa3d 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -120,10 +120,14 @@
 							 0 27 0x1 0x0>;	/* PA27 periph A */
 					};
 
-					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
+					pinctrl_usart0_rts: usart0_rts-0 {
 						atmel,pins =
-							<0 28 0x1 0x0	/* PA28 periph A */
-							 0 29 0x1 0x0>;	/* PA29 periph A */
+							<0 28 0x1 0x0>;	/* PA28 periph A */
+					};
+
+					pinctrl_usart0_cts: usart0_cts-0 {
+						atmel,pins =
+							<0 29 0x1 0x0>;	/* PA29 periph A */
 					};
 				};
 
@@ -134,10 +138,14 @@
 							 3 1 0x1 0x0>;	/* PD1 periph A */
 					};
 
-					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
+					pinctrl_usart1_rts: usart1_rts-0 {
 						atmel,pins =
-							<3 7 0x2 0x0	/* PD7 periph B */
-							 3 8 0x2 0x0>;	/* PD8 periph B */
+							<3 7 0x2 0x0>;	/* PD7 periph B */
+					};
+
+					pinctrl_usart1_cts: usart1_cts-0 {
+						atmel,pins =
+							<3 8 0x2 0x0>;	/* PD8 periph B */
 					};
 				};
 
@@ -148,10 +156,14 @@
 							 3 3 0x1 0x0>;	/* PD3 periph A */
 					};
 
-					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
+					pinctrl_usart2_rts: usart2_rts-0 {
+						atmel,pins =
+							<3 5 0x2 0x0>;	/* PD5 periph B */
+					};
+
+					pinctrl_usart2_cts: usart2_cts-0 {
 						atmel,pins =
-							<3 5 0x2 0x0	/* PD5 periph B */
-							 4 6 0x2 0x0>;	/* PD6 periph B */
+							<4 6 0x2 0x0>;	/* PD6 periph B */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 3434373..e6a57a3 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -38,7 +38,10 @@
 			};
 
 			usart0: serial at fff8c000 {
-				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts_cts>;
+				pinctrl-0 = <
+					&pinctrl_usart0
+					&pinctrl_usart0_rts
+					&pinctrl_usart0_cts>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 04f048f..59244d9 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -37,7 +37,8 @@
 			usart0: serial at fffb0000 {
 				pinctrl-0 =
 					<&pinctrl_usart0
-					 &pinctrl_usart0_rts_cts
+					 &pinctrl_usart0_rts
+					 &pinctrl_usart0_cts
 					 &pinctrl_usart0_dtr_dsr
 					 &pinctrl_usart0_dcd
 					 &pinctrl_usart0_ri>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 56ce896..dc9a4ee 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -139,10 +139,14 @@
 							 1 18 0x1 0x0>;	/* PB18 periph A */
 					};
 
-					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
+					pinctrl_usart0_rts: usart0_rts-0 {
 						atmel,pins =
-							<1 17 0x2 0x0	/* PB17 periph B */
-							 1 15 0x2 0x0>;	/* PB15 periph B */
+							<1 17 0x2 0x0>;	/* PB17 periph B */
+					};
+
+					pinctrl_usart0_cts: usart0_cts-0 {
+						atmel,pins =
+							<1 15 0x2 0x0>;	/* PB15 periph B */
 					};
 				};
 
@@ -153,10 +157,14 @@
 							 1 5 0x1 0x0>;	/* PB5 periph A */
 					};
 
-					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
+					pinctrl_usart1_rts: usart1_rts-0 {
+						atmel,pins =
+							<3 16 0x1 0x0>;	/* PD16 periph A */
+					};
+
+					pinctrl_usart1_cts: usart1_cts-0 {
 						atmel,pins =
-							<3 16 0x1 0x0	/* PD16 periph A */
-							 3 17 0x1 0x0>;	/* PD17 periph A */
+							<3 17 0x1 0x0>;	/* PD17 periph A */
 					};
 				};
 
@@ -167,10 +175,14 @@
 							 1 7 0x1 0x0>;	/* PB7 periph A */
 					};
 
-					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
+					pinctrl_usart2_rts: usart2_rts-0 {
 						atmel,pins =
-							<2 9 0x2 0x0	/* PC9 periph B */
-							 2 11 0x2 0x0>;	/* PC11 periph B */
+							<2 9 0x2 0x0>;	/* PC9 periph B */
+					};
+
+					pinctrl_usart2_cts: usart2_cts-0 {
+						atmel,pins =
+							<2 11 0x2 0x0>;	/* PC11 periph B */
 					};
 				};
 
@@ -181,10 +193,14 @@
 							 1 9 0x1 0x0>;	/* PB8 periph A */
 					};
 
-					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
+					pinctrl_usart3_rts: usart3_rts-0 {
+						atmel,pins =
+							<0 23 0x2 0x0>;	/* PA23 periph B */
+					};
+
+					pinctrl_usart3_cts: usart3_cts-0 {
 						atmel,pins =
-							<0 23 0x2 0x0	/* PA23 periph B */
-							 0 24 0x2 0x0>;	/* PA24 periph B */
+							<0 24 0x2 0x0>;	/* PA24 periph B */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 0d9674b..afd5867 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -39,7 +39,10 @@
 			};
 
 			usart1: serial at fff90000 {
-				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
+				pinctrl-0 =
+					<&pinctrl_usart1
+					 &pinctrl_usart1_rts
+					 &pinctrl_usart1_cts>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 10547bc..1667937 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -132,10 +132,14 @@
 							 0 0 0x1 0x0>;	/* PA0 periph A */
 					};
 
-					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
+					pinctrl_usart0_rts: usart0_rts-0 {
 						atmel,pins =
-							<0 2 0x1 0x0	/* PA2 periph A */
-							 0 3 0x1 0x0>;	/* PA3 periph A */
+							<0 2 0x1 0x0>;	/* PA2 periph A */
+					};
+
+					pinctrl_usart0_cts: usart0_cts-0 {
+						atmel,pins =
+							<0 3 0x1 0x0>;	/* PA3 periph A */
 					};
 				};
 
@@ -154,10 +158,14 @@
 							 0 7 0x1 0x0>;	/* PA7 periph A */
 					};
 
-					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
+					pinctrl_usart2_rts: usart2_rts-0 {
 						atmel,pins =
-							<1 0 0x2 0x0	/* PB0 periph B */
-							 1 1 0x2 0x0>;	/* PB1 periph B */
+							<1 0 0x2 0x0>;	/* PB0 periph B */
+					};
+
+					pinctrl_usart2_cts: usart2_cts-0 {
+						atmel,pins =
+							<1 1 0x2 0x0>;	/* PB1 periph B */
 					};
 				};
 
@@ -168,10 +176,14 @@
 							 2 22 0x2 0x0>;	/* PC22 periph B */
 					};
 
-					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
+					pinctrl_usart3_rts: usart3_rts-0 {
+						atmel,pins =
+							<2 24 0x2 0x0>;	/* PC24 periph B */
+					};
+
+					pinctrl_usart3_cts: usart3_cts-0 {
 						atmel,pins =
-							<2 24 0x2 0x0	/* PC24 periph B */
-							 2 25 0x2 0x0>;	/* PC25 periph B */
+							<2 25 0x2 0x0>;	/* PC25 periph B */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 9dac006..3642ab1 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -133,10 +133,14 @@
 							 0 1 0x1 0x0>;	/* PA1 periph A */
 					};
 
-					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
+					pinctrl_usart0_rts: usart0_rts-0 {
 						atmel,pins =
-							<0 2 0x1 0x0	/* PA2 periph A */
-							 0 3 0x1 0x0>;	/* PA3 periph A */
+							<0 2 0x1 0x0>;	/* PA2 periph A */
+					};
+
+					pinctrl_usart0_cts: usart0_cts-0 {
+						atmel,pins =
+							<0 3 0x1 0x0>;	/* PA3 periph A */
 					};
 				};
 
@@ -147,10 +151,14 @@
 							 0 6 0x1 0x0>;	/* PA6 periph A */
 					};
 
-					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
+					pinctrl_usart1_rts: usart1_rts-0 {
+						atmel,pins =
+							<3 27 0x3 0x0>;	/* PC27 periph C */
+					};
+
+					pinctrl_usart1_cts: usart1_cts-0 {
 						atmel,pins =
-							<3 27 0x3 0x0	/* PC27 periph C */
-							 3 28 0x3 0x0>;	/* PC28 periph C */
+							<3 28 0x3 0x0>;	/* PC28 periph C */
 					};
 				};
 
@@ -161,10 +169,14 @@
 							 0 8 0x1 0x0>;	/* PA8 periph A */
 					};
 
-					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
+					pinctrl_uart2_rts: uart2_rts-0 {
 						atmel,pins =
-							<0 0 0x2 0x0	/* PB0 periph B */
-							 0 1 0x2 0x0>;	/* PB1 periph B */
+							<0 0 0x2 0x0>;	/* PB0 periph B */
+					};
+
+					pinctrl_uart2_cts: uart2_cts-0 {
+						atmel,pins =
+							<0 1 0x2 0x0>;	/* PB1 periph B */
 					};
 				};
 
@@ -175,10 +187,14 @@
 							 3 23 0x2 0x0>;	/* PC23 periph B */
 					};
 
-					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
+					pinctrl_usart3_rts: usart3_rts-0 {
+						atmel,pins =
+							<3 24 0x2 0x0>;	/* PC24 periph B */
+					};
+
+					pinctrl_usart3_cts: usart3_cts-0 {
 						atmel,pins =
-							<3 24 0x2 0x0	/* PC24 periph B */
-							 3 25 0x2 0x0>;	/* PC25 periph B */
+							<3 25 0x2 0x0>;	/* PC25 periph B */
 					};
 				};
 
-- 
1.7.10.4
