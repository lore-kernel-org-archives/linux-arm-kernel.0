From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 18 Jan 2013 17:41:21 +0100
Subject: [PATCH] at91sam9x5 DTS: correct wrong PIO BANK values on u(s)arts
Message-ID: <1358527281-23991-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PIN_BANK 3 is for PDxx pins, not PCxx pins.
And PIN_BANK 1 is for PBxx, not PIN_BANK 0.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 8148bd9..80cd9ad 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -159,12 +159,12 @@
 
 					pinctrl_usart1_rts: usart1_rts-0 {
 						atmel,pins =
-							<3 27 0x3 0x0>;	/* PC27 periph C */
+							<2 27 0x3 0x0>;	/* PC27 periph C */
 					};
 
 					pinctrl_usart1_cts: usart1_cts-0 {
 						atmel,pins =
-							<3 28 0x3 0x0>;	/* PC28 periph C */
+							<2 28 0x3 0x0>;	/* PC28 periph C */
 					};
 				};
 
@@ -177,46 +177,46 @@
 
 					pinctrl_uart2_rts: uart2_rts-0 {
 						atmel,pins =
-							<0 0 0x2 0x0>;	/* PB0 periph B */
+							<1 0 0x2 0x0>;	/* PB0 periph B */
 					};
 
 					pinctrl_uart2_cts: uart2_cts-0 {
 						atmel,pins =
-							<0 1 0x2 0x0>;	/* PB1 periph B */
+							<1 1 0x2 0x0>;	/* PB1 periph B */
 					};
 				};
 
 				usart3 {
 					pinctrl_uart3: usart3-0 {
 						atmel,pins =
-							<3 23 0x2 0x1	/* PC22 periph B with pullup */
-							 3 23 0x2 0x0>;	/* PC23 periph B */
+							<2 23 0x2 0x1	/* PC22 periph B with pullup */
+							 2 23 0x2 0x0>;	/* PC23 periph B */
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
 						atmel,pins =
-							<3 24 0x2 0x0>;	/* PC24 periph B */
+							<2 24 0x2 0x0>;	/* PC24 periph B */
 					};
 
 					pinctrl_usart3_cts: usart3_cts-0 {
 						atmel,pins =
-							<3 25 0x2 0x0>;	/* PC25 periph B */
+							<2 25 0x2 0x0>;	/* PC25 periph B */
 					};
 				};
 
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<3 8 0x3 0x0	/* PC8 periph C */
-							 3 9 0x3 0x1>;	/* PC9 periph C with pullup */
+							<2 8 0x3 0x0	/* PC8 periph C */
+							 2 9 0x3 0x1>;	/* PC9 periph C with pullup */
 					};
 				};
 
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<3 16 0x3 0x0	/* PC16 periph C */
-							 3 17 0x3 0x1>;	/* PC17 periph C with pullup */
+							<2 16 0x3 0x0	/* PC16 periph C */
+							 2 17 0x3 0x1>;	/* PC17 periph C with pullup */
 					};
 				};
 
-- 
1.7.2.5
