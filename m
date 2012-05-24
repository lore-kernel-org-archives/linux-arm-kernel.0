From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 24 May 2012 17:15:55 +0200
Subject: [PATCH 3/4 v5] ARM: dts: add nodes for atmel hsmci controllers for
 atmel SOCs
In-Reply-To: <1337872556-17667-1-git-send-email-ludovic.desroches@atmel.com>
References: <1337872556-17667-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1337872556-17667-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add mci controller nodes to atmel SOCs.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   18 ++++++++++++++++++
 5 files changed, 72 insertions(+), 0 deletions(-)

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
