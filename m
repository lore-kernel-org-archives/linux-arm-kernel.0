From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu, 17 Apr 2014 10:45:29 +0200
Subject: [PATCH 2/2] ARM: dts: berlin: add the BG2CD GPIO nodes
In-Reply-To: <1397724329-14154-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397724329-14154-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397724329-14154-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin BG2CD has 32 GPIOs in SoC power domain and 16 in the SM one.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 102 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 094968c27533..6eb1bdae23ac 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -87,6 +87,78 @@
 			ranges = <0 0xe80000 0x10000>;
 			interrupt-parent = <&aic>;
 
+			gpio0: gpio at 0400 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x0400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				porta: gpio-port at 0 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <8>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <0>;
+				};
+			};
+
+			gpio1: gpio at 0800 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x0800 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				portb: gpio-port at 1 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <8>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <1>;
+				};
+			};
+
+			gpio2: gpio at 0c00 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x0c00 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				portc: gpio-port at 2 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <8>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <2>;
+				};
+			};
+
+			gpio3: gpio at 1000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x1000 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				portd: gpio-port at 3 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <8>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <3>;
+				};
+			};
+
 			timer0: timer at 2c00 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
@@ -177,6 +249,36 @@
 			ranges = <0 0xfc0000 0x10000>;
 			interrupt-parent = <&sic>;
 
+			sm_gpio1: gpio at 5000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x5000 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				portf: gpio-port at 5 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <8>;
+					reg = <0>;
+				};
+			};
+
+			sm_gpio0: gpio at c000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0xc000 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				porte: gpio-port at 4 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <8>;
+					reg = <0>;
+				};
+			};
+
 			uart0: serial at 9000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x9000 0x100>;
-- 
1.8.3.2
