From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 19 Dec 2013 11:59:17 +0800
Subject: [PATCH 2/3] ARM: at91: add PWM device node
In-Reply-To: <1387425558-8589-1-git-send-email-voice.shen@atmel.com>
References: <1387425558-8589-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1387425558-8589-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM device node for AT91 series SoC.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |    9 +++++++++
 arch/arm/boot/dts/sama5d3.dtsi     |   10 ++++++++++
 5 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index d5bd65f..94de2f8 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -30,6 +30,7 @@
 		i2c0 = &i2c0;
 		ssc0 = &ssc0;
 		ssc1 = &ssc1;
+		pwm0 = &pwm0;
 	};
 	cpus {
 		#address-cells = <0>;
@@ -547,6 +548,14 @@
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
 			};
+
+			pwm0: pwm at fffb8000 {
+				compatible = "atmel,at91sam9rl-pwm";
+				reg = <0xfffb8000 0x300>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 4>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c3e5148..d2b29be 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -37,6 +37,7 @@
 		i2c1 = &i2c1;
 		ssc0 = &ssc0;
 		ssc1 = &ssc1;
+		pwm0 = &pwm0;
 	};
 	cpus {
 		#address-cells = <0>;
@@ -725,6 +726,14 @@
 					atmel,can-isoc;
 				};
 			};
+
+			pwm0: pwm at fffb8000 {
+				compatible = "atmel,at91sam9rl-pwm";
+				reg = <0xfffb8000 0x300>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 4>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 6224f9f..7248270 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -33,6 +33,7 @@
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		ssc0 = &ssc0;
+		pwm0 = &pwm0;
 	};
 	cpus {
 		#address-cells = <0>;
@@ -542,6 +543,14 @@
 				reg = <0xfffffe40 0x10>;
 				status = "disabled";
 			};
+
+			pwm0: pwm at f8034000 {
+				compatible = "atmel,at91sam9rl-pwm";
+				reg = <0xf8034000 0x300>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 40267a1..6e5e9cf 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -35,6 +35,7 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		ssc0 = &ssc0;
+		pwm0 = &pwm0;
 	};
 	cpus {
 		#address-cells = <0>;
@@ -762,6 +763,14 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				status = "disabled";
 			};
+
+			pwm0: pwm at f8034000 {
+				compatible = "atmel,at91sam9rl-pwm";
+				reg = <0xf8034000 0x300>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index de9fece..02cca2e 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -37,6 +37,7 @@
 		i2c2 = &i2c2;
 		ssc0 = &ssc0;
 		ssc1 = &ssc1;
+		pwm0 = &pwm0;
 	};
 	cpus {
 		#address-cells = <1>;
@@ -179,6 +180,15 @@
 				status = "disabled";
 			};
 
+			pwm0: pwm at f002c000 {
+				compatible = "atmel,sama5d3-pwm";
+				reg = <0xf002c000 0x300>;
+				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 4>;
+				#pwm-cells = <3>;
+				clocks = <&pwm_clk>;
+				status = "disabled";
+			};
+
 			isi: isi at f0034000 {
 				compatible = "atmel,at91sam9g45-isi";
 				reg = <0xf0034000 0x4000>;
-- 
1.7.9.5
