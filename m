From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 12 Sep 2012 08:42:16 +0200
Subject: [PATCH v3 7/8] ARM: dts: add twi nodes for atmel SoCs
In-Reply-To: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
References: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1347432137-25058-8-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add TWI nodes for atmel SoCs but keep i2c-gpio ones in order to let the
choice to the user in dts files.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 10 ++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 10 ++++++++++
 arch/arm/boot/dts/at91sam9g20.dtsi |  4 ++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 30 ++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 66389c1..edef452 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -28,6 +28,7 @@
 		gpio2 = &pioC;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
 	};
 	cpus {
 		cpu at 0 {
@@ -199,6 +200,15 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c at fffac000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xfffac000 0x100>;
+				interrupts = <11 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc at fffe0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index b460d6c..e7942c7 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -24,6 +24,7 @@
 		gpio3 = &pioD;
 		gpio4 = &pioE;
 		tcb0 = &tcb0;
+		i2c0 = &i2c0;
 	};
 	cpus {
 		cpu at 0 {
@@ -180,6 +181,15 @@
 				interrupts = <24 4 2>;
 				status = "disabled";
 			};
+
+			i2c0: i2c at fff88000 {
+				compatible = "atmel,at91sam9263-i2c";
+				reg = <0xfff88000 0x100>;
+				interrupts = <13 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 2a1d1ca..75ce6e7 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -18,6 +18,10 @@
 
 	ahb {
 		apb {
+			i2c0: i2c at fffac000 {
+				compatible = "atmel,at91sam9g20-i2c";
+			};
+
 			adc0: adc at fffe0000 {
 				atmel,adc-startup-time = <40>;
 			};
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index bafa880..ae4bb6d 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -29,6 +29,8 @@
 		gpio4 = &pioE;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 	};
 	cpus {
 		cpu at 0 {
@@ -201,6 +203,24 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c at fff84000 {
+				compatible = "atmel,at91sam9g10-i2c";
+				reg = <0xfff84000 0x100>;
+				interrupts = <12 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at fff88000 {
+				compatible = "atmel,at91sam9g10-i2c";
+				reg = <0xfff88000 0x100>;
+				interrupts = <13 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc at fffb0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffb0000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bfac0df..42e9fba 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -26,6 +26,8 @@
 		gpio3 = &pioD;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 	};
 	cpus {
 		cpu at 0 {
@@ -178,6 +180,24 @@
 				atmel,use-dma-tx;
 				status = "disabled";
 			};
+
+			i2c0: i2c at f8010000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8010000 0x100>;
+				interrupts = <9 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at f8014000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8014000 0x100>;
+				interrupts = <10 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 4a18c39..e05afbc 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -27,6 +27,9 @@
 		gpio3 = &pioD;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
 	};
 	cpus {
 		cpu at 0 {
@@ -192,6 +195,33 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c at f8010000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8010000 0x100>;
+				interrupts = <9 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at f8014000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8014000 0x100>;
+				interrupts = <10 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at f8018000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8018000 0x100>;
+				interrupts = <11 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc at f804c000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xf804c000 0x100>;
-- 
1.7.11.3
