From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:02:10 +0200
Subject: [PATCH 13/14] arm: at91: dt: at91sam9 add nand pinctrl support
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1344603731-32667-13-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   10 ++++++++++
 5 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 8ee7cd3..a4f4cba 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -208,6 +208,14 @@
 					};
 				};
 
+				nand {
+					pinctrl_nand: nand-0 {
+						atmel,pins =
+							<2 13 0x0 0x1	/* PC13 gpio RDY pin pull_up */
+							 2 14 0x0 0x1>;	/* PC14 gpio enable pin pull_up */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -370,6 +378,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioC 13 0
 				 &pioC 14 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 2d054c2..9314c32 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -155,6 +155,14 @@
 					};
 				};
 
+				nand {
+					pinctrl_nand: nand-0 {
+						atmel,pins =
+							<0 22 0x0 0x1	/* PA22 gpio RDY pin pull_up*/
+							 3 15 0x0 0x1>;	/* PD15 gpio enable pin pull_up */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -267,6 +275,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioA 22 0
 				 &pioD 15 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index cfe197a..8863fd9 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -188,6 +188,14 @@
 					};
 				};
 
+				nand {
+					pinctrl_nand: nand-0 {
+						atmel,pins =
+							<2 8 0x0 0x1	/* PC8 gpio RDY pin pull_up*/
+							 2 14 0x0 0x1>;	/* PC14 gpio enable pin pull_up */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -341,6 +349,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioC 8 0
 				 &pioC 14 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 36a6ce0..d1f5655 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -190,6 +190,14 @@
 					};
 				};
 
+				nand {
+					pinctrl_nand: nand-0 {
+						atmel,pins =
+							<3 5 0x0 0x1	/* PD5 gpio RDY pin pull_up*/
+							 3 4 0x0 0x1>;	/* PD4 gpio enable pin pull_up */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -292,6 +300,8 @@
 			       >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioD 5 0
 				 &pioD 4 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index c585f04..e58965d6 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -204,6 +204,14 @@
 					};
 				};
 
+				nand {
+					pinctrl_nand: nand-0 {
+						atmel,pins =
+							<3 4 0x0 0x1	/* PD5 gpio RDY pin pull_up */
+							 3 5 0x0 0x1>;	/* PD4 gpio enable pin pull_up */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -346,6 +354,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioD 5 0
 				 &pioD 4 0
 				 0
-- 
1.7.10.4
