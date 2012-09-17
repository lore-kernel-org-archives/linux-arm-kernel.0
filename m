From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:27:12 +0200
Subject: [PATCH 15/16] arm: at91: dt: at91sam9 add nand pinctrl support
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-15-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   10 ++++++++++
 5 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index a3d7132..00f96ff 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -207,6 +207,14 @@
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
@@ -372,6 +380,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioC 13 0
 				 &pioC 14 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 8bc4ce7..bc3920e 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -154,6 +154,14 @@
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
@@ -271,6 +279,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioA 22 0
 				 &pioD 15 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 301458e..1ea95ab 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -186,6 +186,14 @@
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
@@ -344,6 +352,8 @@
 			      >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioC 8 0
 				 &pioC 14 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 699b2f3..56aa1a0 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -189,6 +189,14 @@
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
@@ -295,6 +303,8 @@
 			       >;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
 			gpios = <&pioD 5 0
 				 &pioD 4 0
 				 0
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 6482a85..b035fa6 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -195,6 +195,14 @@
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
@@ -341,6 +349,8 @@
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
