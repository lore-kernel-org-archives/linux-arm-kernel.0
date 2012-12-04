From: manabian@gmail.com (Joachim Eastwood)
Date: Tue,  4 Dec 2012 19:10:58 +0100
Subject: [PATCH 3/4] ARM: at91: add SSC bindings to RM9200 DT
In-Reply-To: <1354644659-31385-1-git-send-email-manabian@gmail.com>
References: <1354644659-31385-1-git-send-email-manabian@gmail.com>
Message-ID: <1354644659-31385-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 78 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 73edf021..6ff27bb 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -29,6 +29,9 @@
 		gpio3 = &pioD;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		ssc0 = &ssc0;
+		ssc1 = &ssc1;
+		ssc2 = &ssc2;
 	};
 	cpus {
 		cpu at 0 {
@@ -97,6 +100,33 @@
 				status = "disabled";
 			};
 
+			ssc0: ssc at fffd0000 {
+				compatible = "atmel,at91rm9200-ssc";
+				reg = <0xfffd0000 0x4000>;
+				interrupts = <14 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+				status = "disable";
+			};
+
+			ssc1: ssc at fffd4000 {
+				compatible = "atmel,at91rm9200-ssc";
+				reg = <0xfffd4000 0x4000>;
+				interrupts = <15 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
+				status = "disable";
+			};
+
+			ssc2: ssc at fffd8000 {
+				compatible = "atmel,at91rm9200-ssc";
+				reg = <0xfffd8000 0x4000>;
+				interrupts = <16 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc2_tx &pinctrl_ssc2_rx>;
+				status = "disable";
+			};
+
 			pinctrl at fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -249,6 +279,54 @@
 					};
 				};
 
+				ssc0 {
+					pinctrl_ssc0_tx: ssc0_tx-0 {
+						atmel,pins =
+							<1 0 0x1 0x0	/* PB0 periph A */
+							 1 1 0x1 0x0	/* PB1 periph A */
+							 1 2 0x1 0x0>;	/* PB2 periph A */
+					};
+
+					pinctrl_ssc0_rx: ssc0_rx-0 {
+						atmel,pins =
+							<1 3 0x1 0x0	/* PB3 periph A */
+							 1 4 0x1 0x0	/* PB4 periph A */
+							 1 5 0x1 0x0>;	/* PB5 periph A */
+					};
+				};
+
+				ssc1 {
+					pinctrl_ssc1_tx: ssc1_tx-0 {
+						atmel,pins =
+							<1 6 0x1 0x0	/* PB6 periph A */
+							 1 7 0x1 0x0	/* PB7 periph A */
+							 1 8 0x1 0x0>;	/* PB8 periph A */
+					};
+
+					pinctrl_ssc1_rx: ssc1_rx-0 {
+						atmel,pins =
+							<1 9 0x1 0x0	/* PB9 periph A */
+							 1 10 0x1 0x0	/* PB10 periph A */
+							 1 11 0x1 0x0>;	/* PB11 periph A */
+					};
+				};
+
+				ssc2 {
+					pinctrl_ssc2_tx: ssc2_tx-0 {
+						atmel,pins =
+							<1 12 0x1 0x0	/* PB12 periph A */
+							 1 13 0x1 0x0	/* PB13 periph A */
+							 1 14 0x1 0x0>;	/* PB14 periph A */
+					};
+
+					pinctrl_ssc2_rx: ssc2_rx-0 {
+						atmel,pins =
+							<1 15 0x1 0x0	/* PB15 periph A */
+							 1 16 0x1 0x0	/* PB16 periph A */
+							 1 17 0x1 0x0>;	/* PB17 periph A */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-- 
1.8.0
