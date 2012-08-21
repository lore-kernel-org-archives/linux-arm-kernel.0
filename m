From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 21 Aug 2012 16:30:49 +0200
Subject: [PATCH 4/5] ARM: dts: add twi nodes for atmel SOCs
In-Reply-To: <1345559345-13988-5-git-send-email-ludovic.desroches@atmel.com>
References: <1345559345-13988-5-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1345559449-14034-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add twi nodes for atmel SOCs and remove i2c-gpio ones.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 23 ++++++-------
 arch/arm/boot/dts/at91sam9263.dtsi | 23 ++++++-------
 arch/arm/boot/dts/at91sam9g45.dtsi | 33 +++++++++++-------
 arch/arm/boot/dts/at91sam9n12.dtsi | 33 +++++++++++-------
 arch/arm/boot/dts/at91sam9x5.dtsi  | 69 +++++++++++++++++---------------------
 5 files changed, 90 insertions(+), 91 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index f449efc..0ab7a3c 100644
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
@@ -198,6 +199,15 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c at fffac000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xfffac000 0x100>;
+				interrupts = <11 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc at fffe0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
@@ -257,17 +267,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c at 0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 23 0 /* sda */
-			 &pioA 24 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 0209913..efb86dd 100644
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
@@ -179,6 +180,15 @@
 				interrupts = <24 4>;
 				status = "disabled";
 			};
+
+			i2c0: i2c at fff88000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xfff88000 0x100>;
+				interrupts = <13 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
@@ -204,17 +214,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c at 0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioB 4 0 /* sda */
-			 &pioB 5 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 7dbccaf..8dd3ff8 100644
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
@@ -200,6 +202,24 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c at fff84000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xfff84000 0x100>;
+				interrupts = <12 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at fff88000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xfff88000 0x100>;
+				interrupts = <13 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc at fffb0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffb0000 0x100>;
@@ -268,17 +288,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c at 0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 20 0 /* sda */
-			 &pioA 21 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index cb84de7..8a1969d 100644
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
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xf8010000 0x100>;
+				interrupts = <9 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at f8014000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xf8014000 0x100>;
+				interrupts = <10 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
@@ -205,17 +225,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c at 0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 30 0 /* sda */
-			 &pioA 31 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 6b3ef43..ec56eaf 100644
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
@@ -191,6 +194,33 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c at f8010000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xf8010000 0x100>;
+				interrupts = <9 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at f8014000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xf8014000 0x100>;
+				interrupts = <10 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at f8018000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xf8018000 0x100>;
+				interrupts = <11 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc at f804c000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xf804c000 0x100>;
@@ -259,43 +289,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c at 0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 30 0 /* sda */
-			 &pioA 31 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	i2c at 1 {
-		compatible = "i2c-gpio";
-		gpios = <&pioC 0 0 /* sda */
-			 &pioC 1 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	i2c at 2 {
-		compatible = "i2c-gpio";
-		gpios = <&pioB 4 0 /* sda */
-			 &pioB 5 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
-- 
1.7.11.3
