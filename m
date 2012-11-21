From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 21 Nov 2012 10:17:09 +0800
Subject: [Resend PATCH v6 1/4] pinctrl: atmel-ssc: add pinctrl support
Message-ID: <1353464229-20846-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl support for atmel ssc peripheral

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Resend
  - based on linux-next-20121115
  - commit id: 3805711eb31d3b980c4a55a6994bbc8b22a9ec65
Change since v5
  - correct the pull setting, without pull up Change since v4
  - This is initial version
---
 arch/arm/boot/dts/at91sam9260.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   32 +++++++++++++++++++++++++-------
 drivers/misc/atmel-ssc.c           |    8 ++++++++
 6 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 3164dcd..f9dc7db 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -217,6 +217,22 @@
 					};
 				};
 
+				ssc0 {
+					pinctrl_ssc0_tx: ssc0_tx-0 {
+						atmel,pins =
+							<1 16 0x1 0x0	/* PB16 periph A */
+							 1 17 0x1 0x0	/* PB17 periph A */
+							 1 18 0x1 0x0>;	/* PB18 periph A */
+					};
+
+					pinctrl_ssc0_rx: ssc0_rx-0 {
+						atmel,pins =
+							<1 19 0x1 0x0	/* PB19 periph A */
+							 1 20 0x1 0x0	/* PB20 periph A */
+							 1 21 0x1 0x0>;	/* PB21 periph A */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -350,6 +366,8 @@
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffbc000 0x4000>;
 				interrupts = <14 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disable";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 96e0bc9..6e9a4ff 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -165,6 +165,38 @@
 					};
 				};
 
+				ssc0 {
+					pinctrl_ssc0_tx: ssc0_tx-0 {
+						atmel,pins =
+							<1 0 0x2 0x0	/* PB0 periph B */
+							 1 1 0x2 0x0	/* PB1 periph B */
+							 1 2 0x2 0x0>;	/* PB2 periph B */
+					};
+
+					pinctrl_ssc0_rx: ssc0_rx-0 {
+						atmel,pins =
+							<1 3 0x2 0x0	/* PB3 periph B */
+							 1 4 0x2 0x0	/* PB4 periph B */
+							 1 5 0x2 0x0>;	/* PB5 periph B */
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
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -262,6 +294,8 @@
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff98000 0x4000>;
 				interrupts = <16 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disable";
 			};
 
@@ -269,6 +303,8 @@
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff9c000 0x4000>;
 				interrupts = <17 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				status = "disable";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c40c3eb..63cf206 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -198,6 +198,38 @@
 					};
 				};
 
+				ssc0 {
+					pinctrl_ssc0_tx: ssc0_tx-0 {
+						atmel,pins =
+							<3 0 0x1 0x0	/* PD0 periph A */
+							 3 1 0x1 0x0	/* PD1 periph A */
+							 3 2 0x1 0x0>;	/* PD2 periph A */
+					};
+
+					pinctrl_ssc0_rx: ssc0_rx-0 {
+						atmel,pins =
+							<3 3 0x1 0x0	/* PD3 periph A */
+							 3 4 0x1 0x0	/* PD4 periph A */
+							 3 5 0x1 0x0>;	/* PD5 periph A */
+					};
+				};
+
+				ssc1 {
+					pinctrl_ssc1_tx: ssc1_tx-0 {
+						atmel,pins =
+							<3 10 0x1 0x0	/* PD10 periph A */
+							 3 11 0x1 0x0	/* PD11 periph A */
+							 3 12 0x1 0x0>;	/* PD12 periph A */
+					};
+
+					pinctrl_ssc1_rx: ssc1_rx-0 {
+						atmel,pins =
+							<3 13 0x1 0x0	/* PD13 periph A */
+							 3 14 0x1 0x0	/* PD14 periph A */
+							 3 15 0x1 0x0>;	/* PD15 periph A */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -331,6 +363,8 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfff9c000 0x4000>;
 				interrupts = <16 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disable";
 			};
 
@@ -338,6 +372,8 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfffa0000 0x4000>;
 				interrupts = <17 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				status = "disable";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 7b644c5..b211da6 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -28,6 +28,7 @@
 		tcb1 = &tcb1;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
+		ssc0 = &ssc0;
 	};
 	cpus {
 		cpu at 0 {
@@ -199,6 +200,22 @@
 					};
 				};
 
+				ssc0 {
+					pinctrl_ssc0_tx: ssc0_tx-0 {
+						atmel,pins =
+							<0 24 0x2 0x0	/* PA24 periph B */
+							 0 25 0x2 0x0	/* PA25 periph B */
+							 0 26 0x2 0x0>;	/* PA26 periph B */
+					};
+
+					pinctrl_ssc0_rx: ssc0_rx-0 {
+						atmel,pins =
+							<0 27 0x2 0x0	/* PA27 periph B */
+							 0 28 0x2 0x0	/* PA28 periph B */
+							 0 29 0x2 0x0>;	/* PA29 periph B */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -249,6 +266,15 @@
 				status = "disabled";
 			};
 
+			ssc0: ssc at f0010000 {
+				compatible = "atmel,at91sam9g45-ssc";
+				reg = <0xf0010000 0x4000>;
+				interrupts = <28 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+				status = "disable";
+			};
+
 			usart0: serial at f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x4000>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 1cb26c28..df84f39 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -88,13 +88,6 @@
 				interrupts = <1 4 7>;
 			};
 
-			ssc0: ssc at f0010000 {
-				compatible = "atmel,at91sam9g45-ssc";
-				reg = <0xf0010000 0x4000>;
-				interrupts = <28 4 5>;
-				status = "disable";
-			};
-
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
@@ -214,6 +207,22 @@
 					};
 				};
 
+				ssc0 {
+					pinctrl_ssc0_tx: ssc0_tx-0 {
+						atmel,pins =
+							<0 24 0x2 0x0	/* PA24 periph B */
+							 0 25 0x2 0x0	/* PA25 periph B */
+							 0 26 0x2 0x0>;	/* PA26 periph B */
+					};
+
+					pinctrl_ssc0_rx: ssc0_rx-0 {
+						atmel,pins =
+							<0 27 0x2 0x0	/* PA27 periph B */
+							 0 28 0x2 0x0	/* PA28 periph B */
+							 0 29 0x2 0x0>;	/* PA29 periph B */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
@@ -266,6 +275,15 @@
 				status = "disabled";
 			};
 
+			ssc0: ssc at f0010000 {
+				compatible = "atmel,at91sam9g45-ssc";
+				reg = <0xf0010000 0x4000>;
+				interrupts = <28 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+				status = "disable";
+			};
+
 			usart0: serial at f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x200>;
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index a769719..3b3d0e0 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 
 /* Serialize access to ssc_list and user count */
 static DEFINE_SPINLOCK(user_lock);
@@ -131,6 +132,13 @@ static int ssc_probe(struct platform_device *pdev)
 	struct resource *regs;
 	struct ssc_device *ssc;
 	const struct atmel_ssc_platform_data *plat_dat;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(&pdev->dev, "Failed to request pinctrl\n");
+		return PTR_ERR(pinctrl);
+	}
 
 	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
 	if (!ssc) {
-- 
1.7.9.5
