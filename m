From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Apr 2014 09:46:35 +0200
Subject: [PATCH v2 2/2] ARM: dts: berlin: add GPIO nodes for the BG2Q
In-Reply-To: <1397634395-7456-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397634395-7456-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397634395-7456-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Berlin BG2Q has 6 GPIO ports compatible with the snps,dw-apb-gpio
driver. This patch add the corresponding device tree nodes.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 102 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index e6e556055dfc..82bf6910e227 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -109,6 +109,78 @@
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
+					snps,nr-gpios = <32>;
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
+					snps,nr-gpios = <32>;
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
+					snps,nr-gpios = <32>;
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
+					snps,nr-gpios = <32>;
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
@@ -181,6 +253,36 @@
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
+			gpio4: gpio at 5000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x5000 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				porte: gpio-port at 4 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <32>;
+					reg = <0>;
+				};
+			};
+
+			gpio5: gpio at c000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0xc000 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				portf: gpio-port at 5 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <32>;
+					reg = <0>;
+				};
+			};
 		};
 
 		pinctrl: pinctrl at 0 {
-- 
1.8.3.2
