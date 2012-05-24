From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 24 May 2012 17:15:56 +0200
Subject: [PATCH 4/4 v5] ARM: dts: add nodes for atmel hsmci controllers for
 atmel boards
In-Reply-To: <1337872556-17667-1-git-send-email-ludovic.desroches@atmel.com>
References: <1337872556-17667-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1337872556-17667-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add mci controller nodes to atmel boards.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts         |   10 ++++++++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   12 ++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts         |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   19 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |    9 +++++++++
 6 files changed, 77 insertions(+), 0 deletions(-)

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
-- 
1.7.5.4
