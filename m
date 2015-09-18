From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 18 Sep 2015 21:47:38 +0800
Subject: [PATCH 2/3] arm64: dts: berlin4ct: add GPIO nodes
In-Reply-To: <1442584059-7319-1-git-send-email-jszhang@marvell.com>
References: <1442584059-7319-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442584059-7319-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell berlin4ct SoC has 6 GPIO ports powered by snps,dw-apb-gpio. This
patch adds the corresponding device tree nodes.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 120 +++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index dd4a10d..a3b5f1d 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -135,6 +135,96 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		apb at e80000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0xe80000 0x10000>;
+			interrupt-parent = <&aic>;
+
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
+			aic: interrupt-controller at 3800 {
+				compatible = "snps,dw-apb-ictl";
+				reg = <0x3800 0x30>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -151,6 +241,36 @@
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			sm_gpio0: gpio at 8000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x8000 0x400>;
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
+			sm_gpio1: gpio at 9000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x9000 0x400>;
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
+
 			uart0: uart at d000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0xd000 0x100>;
-- 
2.5.1
