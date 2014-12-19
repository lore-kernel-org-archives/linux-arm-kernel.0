From: alexanders83@web.de (Alexander Stein)
Date: Fri, 19 Dec 2014 09:51:40 +0100
Subject: [PATCH 3/3] ARM: at91/dt: add EBI (External Bus Interface) node in
 at91sam9263 dtsi
In-Reply-To: <1418979100-13243-1-git-send-email-alexanders83@web.de>
References: <1418979100-13243-1-git-send-email-alexanders83@web.de>
Message-ID: <1418979100-13243-4-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EBI node to at91sam9263 dtsi.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 914990b..9d9ab2a 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -994,6 +994,22 @@
 			status = "disabled";
 		};
 
+		ebi0: ebi0 at 10000000 {
+			compatible = "atmel,at91sam9263-ebi0", "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc0>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x60000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000>;
+			clocks = <&mck>;
+		};
+
 		nand0: nand at 40000000 {
 			compatible = "atmel,at91rm9200-nand";
 			#address-cells = <1>;
@@ -1012,6 +1028,19 @@
 			status = "disabled";
 		};
 
+		ebi1: ebi1 at 70000000 {
+			compatible = "atmel,at91sam9263-ebi1", "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc1>;
+			atmel,matrix = <&matrix>;
+			reg = <0x70000000 0x30000000>;
+			ranges = <0x0 0x0 0x70000000 0x10000000
+				  0x1 0x0 0x80000000 0x10000000
+				  0x2 0x0 0x90000000 0x10000000>;
+			clocks = <&mck>;
+		};
+
 		usb0: ohci at 00a00000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00a00000 0x100000>;
-- 
2.2.1
