From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 23 May 2012 21:42:45 +0200
Subject: [PATCH v4 3/3] ARM: dts: add nodes for atmel hsmci controllers for
 atmel platforms
In-Reply-To: <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
References: <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1337802165-13866-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add nodes for mci controllers.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
v4: add new chips and boards

 arch/arm/boot/dts/at91sam9260.dtsi          |    9 +++++++++
 arch/arm/boot/dts/at91sam9263.dtsi          |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts         |   10 ++++++++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   12 ++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts         |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi          |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   19 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi          |    9 +++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |    9 +++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi           |   18 ++++++++++++++++++
 11 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index f449efc..ae54bf3 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -198,6 +198,15 @@
 				status = "disabled";
 			};
 
+			mmc0: mmc at fffa8000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfffa800 0x600>;
+				interrupts = <9 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
 			adc0: adc at fffe0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 0209913..a327ebe 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -179,6 +179,24 @@
 				interrupts = <24 4>;
 				status = "disabled";
 			};
+
+			mmc0: mmc at fff80000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfff80000 0x600>;
+				interrupts = <10 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mmc1: mmc at fff84000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfff84000 0x600>;
+				interrupts = <11 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index f86ac4b..05028ed 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -50,6 +50,16 @@
 				atmel,vbus-gpio = <&pioA 25 0>;
 				status = "okay";
 			};
+
+			mmc0: mmc at fff80000 {
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioE 18 0>;
+					wp-gpios = <&pioE 19 0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
index f1b2e14..684b229 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
+++ b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
@@ -12,6 +12,18 @@
 	model = "Atmel at91sam9g20ek 2 mmc";
 	compatible = "atmel,at91sam9g20ek_2mmc", "atmel,at91sam9g20", "atmel,at91sam9";
 
+	ahb {
+		apb{
+			mmc0: mmc at fffa8000 {
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioC 2 0>;
+				};
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..7da326a 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -51,6 +51,15 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			mmc0: mmc at fffa8000 {
+				status = "okay";
+				slot at 1 {
+					reg = <1>;
+					bus-width = <4>;
+					cd-gpios = <&pioC 9 0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 7829a4d..422a9fb 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,24 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			mmc0: mmc at f0008000 {
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioD 15 0>;
+				};
+			};
+
+			mmc1: mmc at f000c000 {
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioD 14 0>;
+				};
+			};
 		};
 
 		usb0: ohci at 00600000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 7dbccaf..0360bf8 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -236,6 +236,24 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			mmc0: mmc at fff80000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfff80000 0x600>;
+				interrupts = <11 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mmc1: mmc at fffd0000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfffd0000 0x600>;
+				interrupts = <29 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3633bd..7a7b571 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -46,6 +46,25 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			mmc0: mmc at fff80000 {
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioD 10 0>;
+				};
+			};
+
+			mmc1: mmc at fffd0000 {
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioD 11 0>;
+					wp-gpios = <&pioD 29 0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index cb84de7..f3e03fb 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -82,6 +82,15 @@
 				reg = <0xfffffe10 0x10>;
 			};
 
+			mmc0: mmc at f0008000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf0008000 0x600>;
+				interrupts = <12 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index f4e43e3..44b42d9 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -37,6 +37,15 @@
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
+
+			mmc0: mmc at f0008000 {
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioA 7 0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 6b3ef43..4e8125b 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -228,6 +228,24 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			mmc0: mmc at f0008000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf0008000 0x600>;
+				interrupts = <12 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mmc1: mmc at f000c000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf000c000 0x600>;
+				interrupts = <26 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.5.4
