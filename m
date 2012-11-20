From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:31:41 +0100
Subject: [PATCH 3/5] ARM: at91sam9: add macb pinctrl support
In-Reply-To: <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121120212326.GO4398@game.jcrosoft.org>
 <1353447103-31616-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353447103-31616-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   42 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   30 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   30 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x25.dtsi |   21 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   30 ++++++++++++++++++++++++++
 5 files changed, 153 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 9a24ffb..36f55e3 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -216,6 +216,46 @@
 					};
 				};
 
+				macb {
+					pinctrl_macb_rmii: macb_rmii-0 {
+						atmel,pins =
+							<0 12 0x1 0x0	/* PA12 periph A */
+							 0 13 0x1 0x0	/* PA13 periph A */
+							 0 14 0x1 0x0	/* PA14 periph A */
+							 0 15 0x1 0x0	/* PA15 periph A */
+							 0 16 0x1 0x0	/* PA16 periph A */
+							 0 17 0x1 0x0	/* PA17 periph A */
+							 0 18 0x1 0x0	/* PA18 periph A */
+							 0 19 0x1 0x0	/* PA19 periph A */
+							 0 20 0x1 0x0	/* PA20 periph A */
+							 0 21 0x1 0x0>;	/* PA21 periph A */
+					};
+
+					pinctrl_macb_rmii_mii: macb_rmii_mii-0 {
+						atmel,pins =
+							<0 22 0x2 0x0	/* PA22 periph B */
+							 0 23 0x2 0x0	/* PA23 periph B */
+							 0 24 0x2 0x0	/* PA24 periph B */
+							 0 25 0x2 0x0	/* PA25 periph B */
+							 0 26 0x2 0x0	/* PA26 periph B */
+							 0 27 0x2 0x0	/* PA27 periph B */
+							 0 28 0x2 0x0	/* PA28 periph B */
+							 0 29 0x2 0x0>;	/* PA29 periph B */
+					};
+
+					pinctrl_macb_rmii_mii_alt: macb_rmii_mii-1 {
+						atmel,pins =
+							<0 10 0x2 0x0	/* PA10 periph B */
+							 0 11 0x2 0x0	/* PA11 periph B */
+							 0 24 0x2 0x0	/* PA24 periph B */
+							 0 25 0x2 0x0	/* PA25 periph B */
+							 0 26 0x2 0x0	/* PA26 periph B */
+							 0 27 0x2 0x0	/* PA27 periph B */
+							 0 28 0x2 0x0	/* PA28 periph B */
+							 0 29 0x2 0x0>;	/* PA29 periph B */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -326,6 +366,8 @@
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffc4000 0x100>;
 				interrupts = <21 4 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb_rmii>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 251ccec..148b89a 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -163,6 +163,34 @@
 					};
 				};
 
+				macb {
+					pinctrl_macb_rmii: macb_rmii-0 {
+						atmel,pins =
+							<2 25 0x2 0x0	/* PC25 periph B */
+							 4 21 0x1 0x0	/* PE21 periph A */
+							 4 23 0x1 0x0	/* PE23 periph A */
+							 4 24 0x1 0x0	/* PE24 periph A */
+							 4 25 0x1 0x0	/* PE25 periph A */
+							 4 26 0x1 0x0	/* PE26 periph A */
+							 4 27 0x1 0x0	/* PE27 periph A */
+							 4 28 0x1 0x0	/* PE28 periph A */
+							 4 29 0x1 0x0	/* PE29 periph A */
+							 4 30 0x1 0x0>;	/* PE30 periph A */
+					};
+
+					pinctrl_macb_rmii_mii: macb_rmii_mii-0 {
+						atmel,pins =
+							<2 20 0x2 0x0	/* PC20 periph B */
+							 2 21 0x2 0x0	/* PC21 periph B */
+							 2 22 0x2 0x0	/* PC22 periph B */
+							 2 23 0x2 0x0	/* PC23 periph B */
+							 2 24 0x2 0x0	/* PC24 periph B */
+							 2 25 0x2 0x0	/* PC25 periph B */
+							 2 27 0x2 0x0	/* PC27 periph B */
+							 4 22 0x2 0x0>;	/* PE22 periph B */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -260,6 +288,8 @@
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffbc000 0x100>;
 				interrupts = <21 4 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb_rmii>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c340f66..0ad84b6 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -196,6 +196,34 @@
 					};
 				};
 
+				macb {
+					pinctrl_macb_rmii: macb_rmii-0 {
+						atmel,pins =
+							<0 10 0x1 0x0	/* PA10 periph A */
+							 0 11 0x1 0x0	/* PA11 periph A */
+							 0 12 0x1 0x0	/* PA12 periph A */
+							 0 13 0x1 0x0	/* PA13 periph A */
+							 0 14 0x1 0x0	/* PA14 periph A */
+							 0 15 0x1 0x0	/* PA15 periph A */
+							 0 16 0x1 0x0	/* PA16 periph A */
+							 0 17 0x1 0x0	/* PA17 periph A */
+							 0 18 0x1 0x0	/* PA18 periph A */
+							 0 19 0x1 0x0>;	/* PA19 periph A */
+					};
+
+					pinctrl_macb_rmii_mii: macb_rmii_mii-0 {
+						atmel,pins =
+							<0 6 0x2 0x0	/* PA6 periph B */
+							 0 7 0x2 0x0	/* PA7 periph B */
+							 0 8 0x2 0x0	/* PA8 periph B */
+							 0 9 0x2 0x0	/* PA9 periph B */
+							 0 27 0x2 0x0	/* PA27 periph B */
+							 0 28 0x2 0x0	/* PA28 periph B */
+							 0 29 0x2 0x0	/* PA29 periph B */
+							 0 30 0x2 0x0>;	/* PA30 periph B */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -304,6 +332,8 @@
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffbc000 0x100>;
 				interrupts = <25 4 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb_rmii>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
index 956c65f..54eb33b 100644
--- a/arch/arm/boot/dts/at91sam9x25.dtsi
+++ b/arch/arm/boot/dts/at91sam9x25.dtsi
@@ -22,6 +22,27 @@
 				       0x80000000 0xfffd0000 0xb83fffff  /* pioC */
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
+
+				macb1 {
+					pinctrl_macb1_rmii: macb1_rmii-0 {
+						atmel,pins =
+							<2 16 0x2 0x0	/* PC16 periph B */
+							 2 18 0x2 0x0	/* PC18 periph B */
+							 2 19 0x2 0x0	/* PC19 periph B */
+							 2 20 0x2 0x0	/* PC20 periph B */
+							 2 21 0x2 0x0	/* PC21 periph B */
+							 2 27 0x2 0x0	/* PC27 periph B */
+							 2 28 0x2 0x0	/* PC28 periph B */
+							 2 29 0x2 0x0	/* PC29 periph B */
+							 2 30 0x2 0x0	/* PC30 periph B */
+							 2 31 0x2 0x0>;	/* PC31 periph B */
+					};
+				};
+			};
+
+			macb1: ethernet at f8030000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb1_rmii>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 6a40b77..9fd7159 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -206,6 +206,34 @@
 					};
 				};
 
+				macb0 {
+					pinctrl_macb0_rmii: macb0_rmii-0 {
+						atmel,pins =
+							<1 0 0x1 0x0	/* PB0 periph A */
+							 1 1 0x1 0x0	/* PB1 periph A */
+							 1 2 0x1 0x0	/* PB2 periph A */
+							 1 3 0x1 0x0	/* PB3 periph A */
+							 1 4 0x1 0x0	/* PB4 periph A */
+							 1 5 0x1 0x0	/* PB5 periph A */
+							 1 6 0x1 0x0	/* PB6 periph A */
+							 1 7 0x1 0x0	/* PB7 periph A */
+							 1 9 0x1 0x0	/* PB9 periph A */
+							 1 10 0x1 0x0>;	/* PB10 periph A */
+					};
+
+					pinctrl_macb0_rmii_mii: macb0_rmii_mii-0 {
+						atmel,pins =
+							<1 8 0x1 0x0	/* PA8 periph A */
+							 1 11 0x1 0x0	/* PA11 periph A */
+							 1 12 0x1 0x0	/* PA12 periph A */
+							 1 13 0x1 0x0	/* PA13 periph A */
+							 1 14 0x1 0x0	/* PA14 periph A */
+							 1 15 0x1 0x0	/* PA15 periph A */
+							 1 16 0x1 0x0	/* PA16 periph A */
+							 1 17 0x1 0x0>;	/* PA17 periph A */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -295,6 +323,8 @@
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
 				interrupts = <24 4 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb0_rmii>;
 				status = "disabled";
 			};
 
-- 
1.7.10.4
