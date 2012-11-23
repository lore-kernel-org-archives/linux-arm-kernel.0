From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 23 Nov 2012 19:45:30 +0100
Subject: [PATCH 1/3] ARM: at91: sam9: add spi dt support
In-Reply-To: <20121123184115.GB4398@game.jcrosoft.org>
References: <20121123184115.GB4398@game.jcrosoft.org>
Message-ID: <1353696332-12741-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for now on does not add 9x5 and 9n12 as they use IP version 2.1 that use DMA
instead of the PDC

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   40 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   40 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   40 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9260.c   |    2 ++
 arch/arm/mach-at91/at91sam9g45.c   |    2 ++
 5 files changed, 124 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index b1d3fab..240a6ed 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -92,6 +92,28 @@
 				interrupts = <17 4 0 18 4 0 19 4 0>;
 			};
 
+			spi0: spi at fffc8000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffc8000 0x4000>;
+				interrupts = <12 4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi0>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffcc000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffcc000 0x4000>;
+				interrupts = <13 4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi1>;
+				status = "disabled";
+			};
+
 			tcb1: timer at fffdc000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffdc000 0x100>;
@@ -305,6 +327,24 @@
 					};
 				};
 
+				spi0 {
+					pinctrl_spi0: spi0-0 {
+						atmel,pins =
+							<0 0 0x1 0x0	/* PA0 periph A */
+							 0 1 0x1 0x0	/* PA1 periph A */
+							 0 2 0x1 0x0>;	/* PA2 periph A */
+					};
+				};
+
+				spi1 {
+					pinctrl_spi1: spi1-0 {
+						atmel,pins =
+							<1 0 0x1 0x0	/* PB0 periph A */
+							 1 1 0x1 0x0	/* PB1 periph A */
+							 1 2 0x1 0x0>;	/* PB2 periph A */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 66106ee..dc118c3 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -269,6 +269,24 @@
 					};
 				};
 
+				spi0 {
+					pinctrl_spi0: spi0-0 {
+						atmel,pins =
+							<0 0 0x2 0x0	/* PA0 periph B */
+							 0 1 0x2 0x0	/* PA1 periph B */
+							 0 2 0x2 0x0>;	/* PA2 periph B */
+					};
+				};
+
+				spi1 {
+					pinctrl_spi1: spi1-0 {
+						atmel,pins =
+							<1 12 0x1 0x0	/* PB12 periph A */
+							 1 13 0x1 0x0	/* PB13 periph A */
+							 1 14 0x1 0x0>;	/* PB14 periph A */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -371,6 +389,28 @@
 				status = "disabled";
 			};
 
+			spi0: spi at fffa4000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x4000>;
+				interrupts = <14 4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi0>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffa8000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x4000>;
+				interrupts = <15 4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi1>;
+				status = "disabled";
+			};
+
 			usb1: gadget at fff78000 {
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfff78000 0x4000>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 0741cae..d0eb2db 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -96,6 +96,28 @@
 				interrupts = <18 4 0>;
 			};
 
+			spi0: spi at fffa4000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x4000>;
+				interrupts = <14 4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi0>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffa8000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x4000>;
+				interrupts = <15 4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi1>;
+				status = "disabled";
+			};
+
 			tcb1: timer at fffd4000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffd4000 0x100>;
@@ -288,6 +310,24 @@
 					};
 				};
 
+				spi0 {
+					pinctrl_spi0: spi0-0 {
+						atmel,pins =
+							<1 0 0x1 0x0	/* PB0 periph A */
+							 1 1 0x1 0x0	/* PB1 periph A */
+							 1 2 0x1 0x0>;	/* PB2 periph A */
+					};
+				};
+
+				spi1 {
+					pinctrl_spi1: spi1-0 {
+						atmel,pins =
+							<1 14 0x1 0x0	/* PB14 periph A */
+							 1 15 0x1 0x0	/* PB15 periph A */
+							 1 16 0x1 0x0>;	/* PB16 periph A */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index c9e029e..64e33e1 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -239,6 +239,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioA_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioB_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioC_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffc8000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffcc000.spi", &spi1_clk)
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index c5c2acc..4f51dbf 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -267,6 +267,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioC_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioDE_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffffa00.gpio", &pioDE_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
 
 	CLKDEV_CON_ID("pioA", &pioA_clk),
 	CLKDEV_CON_ID("pioB", &pioB_clk),
-- 
1.7.10.4
