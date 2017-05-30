From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 30 May 2017 11:20:52 +0200
Subject: [PATCH v2 2/4] ARM: dts: at91: Declare EBI/NAND controllers
In-Reply-To: <1496136054-12390-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1496136054-12390-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1496136054-12390-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare new nodes for the EBI and NAND controllers embedded in various
at91/sama5 SoCs.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |  37 +++++++++
 arch/arm/boot/dts/at91sam9261.dtsi |  32 ++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |  61 ++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |  35 ++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |  42 ++++++++++
 arch/arm/boot/dts/at91sam9rl.dtsi  |  35 ++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |  42 ++++++++++
 arch/arm/boot/dts/sama5d2.dtsi     |  53 ++++++++++++
 arch/arm/boot/dts/sama5d3.dtsi     | 113 ++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d4.dtsi     | 160 +++++++++++++++++++++++++++++++++++++
 10 files changed, 610 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 9e035b21e1b6..ab0e73374567 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -99,6 +99,16 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			smc: smc at ffffec00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
+			matrix: matrix at ffffee00 {
+				compatible = "atmel,at91sam9260-matrix", "syscon";
+				reg = <0xffffee00 0x200>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9260-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
@@ -1011,6 +1021,33 @@
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
+
+		ebi: ebi at 10000000 {
+			compatible = "atmel,at91sam9260-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x80000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000
+				  0x6 0x0 0x70000000 0x10000000
+				  0x7 0x0 0x80000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,at91sam9260-nand-controller";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
 	};
 
 	i2c-gpio-0 {
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 7e80acda8f69..3ab0c21134f1 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -91,6 +91,33 @@
 			status = "disabled";
 		};
 
+		ebi: ebi at 10000000 {
+			compatible = "atmel,at91sam9261-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x80000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000
+				  0x6 0x0 0x70000000 0x10000000
+				  0x7 0x0 0x80000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,at91sam9261-nand-controller";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
 		nand0: nand at 40000000 {
 			compatible = "atmel,at91rm9200-nand";
 			#address-cells = <1>;
@@ -262,6 +289,11 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			smc: smc at ffffec00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
 			matrix: matrix at ffffee00 {
 				compatible = "atmel,at91sam9261-matrix", "syscon";
 				reg = <0xffffee00 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index a1888f6d892b..db9f3a02f2fa 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -361,11 +361,26 @@
 				reg = <0xffffe200 0x200>;
 			};
 
+			smc0: smc at ffffe400 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffe400 0x200>;
+			};
+
 			ramc1: ramc at ffffe800 {
 				compatible = "atmel,at91sam9260-sdramc";
 				reg = <0xffffe800 0x200>;
 			};
 
+			smc1: smc at ffffea00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffea00 0x200>;
+			};
+
+			matrix: matrix at ffffec00 {
+				compatible = "atmel,at91sam9263-matrix", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
@@ -1017,6 +1032,52 @@
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
+
+		ebi0: ebi at 10000000 {
+			compatible = "atmel,at91sam9263-ebi0";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc0>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x80000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller0: nand-controller {
+				compatible = "atmel,at91sam9260-nand-controller";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
+		ebi1: ebi at 70000000 {
+			compatible = "atmel,at91sam9263-ebi1";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc1>;
+			atmel,matrix = <&matrix>;
+			reg = <0x80000000 0x20000000>;
+			ranges = <0x0 0x0 0x80000000 0x10000000
+				  0x1 0x0 0x90000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller1: nand-controller {
+				compatible = "atmel,at91sam9260-nand-controller";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
 	};
 
 	i2c-gpio-0 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index e567d5fd3f9d..392dcfb79b57 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -113,6 +113,16 @@
 				clock-names = "ddrck";
 			};
 
+			smc: smc at ffffe800 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffe800 0x200>;
+			};
+
+			matrix: matrix at ffffea00 {
+				compatible = "atmel,at91sam9g45-matrix", "syscon";
+				reg = <0xffffea00 0x200>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9g45-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
@@ -1314,6 +1324,31 @@
 			clock-names = "usb_clk", "ehci_clk";
 			status = "disabled";
 		};
+
+		ebi: ebi at 10000000 {
+			compatible = "atmel,at91sam9g45-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x80000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,at91sam9g45-nand-controller";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
 	};
 
 	i2c-gpio-0 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index f43d7695352d..df06a66ace07 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -89,6 +89,17 @@
 				atmel,external-irqs = <31>;
 			};
 
+			matrix: matrix at ffffde00 {
+				compatible = "atmel,at91sam9n12-matrix", "syscon";
+				reg = <0xffffde00 0x100>;
+			};
+
+			pmecc: ecc-engine at ffffe000 {
+				compatible = "atmel,at91sam9g45-pmecc";
+				reg = <0xffffe000 0x600>,
+				      <0xffffe600 0x200>;
+			};
+
 			ramc0: ramc at ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
@@ -96,6 +107,11 @@
 				clock-names = "ddrck";
 			};
 
+			smc: smc at ffffea00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffea00 0x200>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9n12-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
@@ -1028,6 +1044,32 @@
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
+
+		ebi: ebi at 10000000 {
+			compatible = "atmel,at91sam9x5-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x60000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,at91sam9g45-nand-controller";
+				ecc-engine = <&pmecc>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
 	};
 
 	i2c-gpio-0 {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index f4c129a98f17..d373400cddcd 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -92,6 +92,31 @@
 			status = "disabled";
 		};
 
+		ebi: ebi at 10000000 {
+			compatible = "atmel,at91sam9rl-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x80000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,at91sam9g45-nand-controller";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
 		nand0: nand at 40000000 {
 			compatible = "atmel,at91rm9200-nand";
 			#address-cells = <1>;
@@ -364,6 +389,16 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			smc: smc at ffffec00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
+			matrix: matrix at ffffee00 {
+				compatible = "atmel,at91sam9rl-matrix", "syscon";
+				reg = <0xffffee00 0x200>;
+			};
+
 			aic: interrupt-controller at fffff000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,at91rm9200-aic";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index f66bae925705..7723e8b02880 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -97,6 +97,17 @@
 				atmel,external-irqs = <31>;
 			};
 
+			matrix: matrix at ffffde00 {
+				compatible = "atmel,at91sam9x5-matrix", "syscon";
+				reg = <0xffffde00 0x100>;
+			};
+
+			pmecc: ecc-engine at ffffe000 {
+				compatible = "atmel,at91sam9g45-pmecc";
+				reg = <0xffffe000 0x600>,
+				      <0xffffe600 0x200>;
+			};
+
 			ramc0: ramc at ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
@@ -104,6 +115,11 @@
 				clock-names = "ddrck";
 			};
 
+			smc: smc at ffffea00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffea00 0x200>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9x5-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
@@ -1236,6 +1252,32 @@
 			clock-names = "usb_clk", "ehci_clk";
 			status = "disabled";
 		};
+
+		ebi: ebi at 10000000 {
+			compatible = "atmel,at91sam9x5-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&smc>;
+			atmel,matrix = <&matrix>;
+			reg = <0x10000000 0x60000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x20000000 0x10000000
+				  0x2 0x0 0x30000000 0x10000000
+				  0x3 0x0 0x40000000 0x10000000
+				  0x4 0x0 0x50000000 0x10000000
+				  0x5 0x0 0x60000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,at91sam9g45-nand-controller";
+				ecc-engine = <&pmecc>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
 	};
 
 	i2c-gpio-0 {
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71c3a38..c6191499c789 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -135,6 +135,12 @@
 		#size-cells = <1>;
 		ranges;
 
+		nfc_sram: sram at 00100000 {
+			compatible = "mmio-sram";
+			no-memory-wc;
+			reg = <0x00100000 0x2400>;
+		};
+
 		usb0: gadget at 00300000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -291,6 +297,32 @@
 			cache-level = <2>;
 		};
 
+		ebi: ebi at 10000000 {
+			compatible = "atmel,sama5d3-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&hsmc>;
+			reg = <0x10000000 0x10000000
+			       0x40000000 0x30000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x60000000 0x10000000
+				  0x2 0x0 0x70000000 0x10000000
+				  0x3 0x0 0x80000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,sama5d3-nand-controller";
+				atmel,nfc-sram = <&nfc_sram>;
+				atmel,nfc-io = <&nfc_io>;
+				ecc-engine = <&pmecc>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
 		nand0: nand at 80000000 {
 			compatible = "atmel,sama5d2-nand";
 			#address-cells = <1>;
@@ -347,6 +379,11 @@
 			status = "disabled";
 		};
 
+		nfc_io: nfc-io at c0000000 {
+			compatible = "atmel,sama5d3-nfc-io", "syscon";
+			reg = <0xc0000000 0x8000000>;
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -986,6 +1023,22 @@
 				clock-names = "t0_clk", "slow_clk";
 			};
 
+			hsmc: hsmc at f8014000 {
+				compatible = "atmel,sama5d3-smc", "syscon", "simple-mfd";
+				reg = <0xf8014000 0x1000>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 6>;
+				clocks = <&hsmc_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pmecc: ecc-engine at ffffc070 {
+					compatible = "atmel,sama5d2-pmecc";
+					reg = <0xffffc070 0x490>,
+					      <0xffffc500 0x100>;
+				};
+			};
+
 			pdmic: pdmic at f8018000 {
 				compatible = "atmel,sama5d2-pdmic";
 				reg = <0xf8018000 0x124>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index b06448ba6649..3925f83f58a6 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -429,6 +429,22 @@
 				clocks = <&trng_clk>;
 			};
 
+			hsmc: hsmc at ffffc000 {
+				compatible = "atmel,sama5d3-smc", "syscon", "simple-mfd";
+				reg = <0xffffc000 0x1000>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 6>;
+				clocks = <&hsmc_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pmecc: ecc-engine at ffffc070 {
+					compatible = "atmel,at91sam9g45-pmecc";
+					reg = <0xffffc070 0x490>,
+					      <0xffffc500 0x100>;
+				};
+			};
+
 			dma0: dma-controller at ffffe600 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe600 0x200>;
@@ -554,6 +570,66 @@
 					};
 				};
 
+				ebi {
+					pinctrl_ebi_addr: ebi-addr-0 {
+						atmel,pins =
+							<AT91_PIOE 1 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 2 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 3 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 5 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 9 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 11 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 13 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 14 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 15 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 16 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 18 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 21 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 22 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 23 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nand_addr: ebi-addr-1 {
+						atmel,pins =
+							<AT91_PIOE 21 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 22 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_cs0: ebi-cs0-0 {
+						atmel,pins =
+							<AT91_PIOE 24 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_cs1: ebi-cs1-0 {
+						atmel,pins =
+							<AT91_PIOE 25 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_cs2: ebi-cs2-0 {
+						atmel,pins =
+							<AT91_PIOE 26 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nwait: ebi-nwait-0 {
+						atmel,pins =
+							<AT91_PIOE 28 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nwr1_nbs1: ebi-nwr1-nbs1-0 {
+						atmel,pins =
+							<AT91_PIOE 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+				};
+
 				i2c0 {
 					pinctrl_i2c0: i2c0-0 {
 						atmel,pins =
@@ -1326,6 +1402,12 @@
 			};
 		};
 
+		nfc_sram: sram at 200000 {
+			compatible = "mmio-sram";
+			no-memory-wc;
+			reg = <0x200000 0x2400>;
+		};
+
 		usb0: gadget at 00500000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1461,6 +1543,32 @@
 			status = "disabled";
 		};
 
+		ebi: ebi at 10000000 {
+			compatible = "atmel,sama5d3-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&hsmc>;
+			reg = <0x10000000 0x10000000
+			       0x40000000 0x30000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x40000000 0x10000000
+				  0x2 0x0 0x50000000 0x10000000
+				  0x3 0x0 0x60000000 0x10000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,sama5d3-nand-controller";
+				atmel,nfc-sram = <&nfc_sram>;
+				atmel,nfc-io = <&nfc_io>;
+				ecc-engine = <&pmecc>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
 		nand0: nand at 60000000 {
 			compatible = "atmel,at91rm9200-nand";
 			#address-cells = <1>;
@@ -1492,5 +1600,10 @@
 				clocks = <&hsmc_clk>;
 			};
 		};
+
+		nfc_io: nfc-io at 70000000 {
+			compatible = "atmel,sama5d3-nfc-io", "syscon";
+			reg = <0x70000000 0x8000000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index d3889c9d25a9..de6bcff87745 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -124,6 +124,12 @@
 		#size-cells = <1>;
 		ranges;
 
+		nfc_sram: sram at 100000 {
+			compatible = "mmio-sram";
+			no-memory-wc;
+			reg = <0x100000 0x2400>;
+		};
+
 		usb0: gadget at 00400000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -280,6 +286,32 @@
 			cache-level = <2>;
 		};
 
+		ebi: ebi at 10000000 {
+			compatible = "atmel,sama5d3-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&hsmc>;
+			reg = <0x10000000 0x10000000
+			       0x60000000 0x28000000>;
+			ranges = <0x0 0x0 0x10000000 0x10000000
+				  0x1 0x0 0x60000000 0x10000000
+				  0x2 0x0 0x70000000 0x10000000
+				  0x3 0x0 0x80000000 0x8000000>;
+			clocks = <&mck>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,sama5d3-nand-controller";
+				atmel,nfc-sram = <&nfc_sram>;
+				atmel,nfc-io = <&nfc_io>;
+				ecc-engine = <&pmecc>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
 		nand0: nand at 80000000 {
 			compatible = "atmel,sama5d4-nand", "atmel,at91rm9200-nand";
 			#address-cells = <1>;
@@ -311,6 +343,11 @@
 			};
 		};
 
+		nfc_io: nfc-io at 90000000 {
+			compatible = "atmel,sama5d3-nfc-io", "syscon";
+			reg = <0x90000000 0x8000000>;
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -1287,6 +1324,22 @@
 				status = "okay";
 			};
 
+			hsmc: smc at fc05c000 {
+				compatible = "atmel,sama5d3-smc", "syscon", "simple-mfd";
+				reg = <0xfc05c000 0x1000>;
+				interrupts = <22 IRQ_TYPE_LEVEL_HIGH 6>;
+				clocks = <&hsmc_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pmecc: ecc-engine at ffffc070 {
+					compatible = "atmel,sama5d4-pmecc";
+					reg = <0xfc05c070 0x490>,
+					      <0xfc05c500 0x100>;
+				};
+			};
+
 			rstc at fc068600 {
 				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
 				reg = <0xfc068600 0x10>;
@@ -1447,6 +1500,113 @@
 					};
 				};
 
+				ebi {
+					pinctrl_ebi_addr: ebi-addr-0 {
+						atmel,pins =
+							<AT91_PIOE 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 1 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 2 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 3 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 5 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 9 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 11 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 13 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 14 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 15 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 16 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 18 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 18 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 21 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 22 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOE 23 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nand_addr: ebi-addr-1 {
+						atmel,pins =
+							<AT91_PIOC 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_cs0: ebi-cs0-0 {
+						atmel,pins =
+							<AT91_PIOE 26 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_cs1: ebi-cs1-0 {
+						atmel,pins =
+							<AT91_PIOE 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_cs2: ebi-cs2-0 {
+						atmel,pins =
+							<AT91_PIOE 28 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_cs3: ebi-cs3-0 {
+						atmel,pins =
+							<AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
+						atmel,pins =
+							<AT91_PIOC 5 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 11 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_data_8_15: ebi-data-msb-0 {
+						atmel,pins =
+							<AT91_PIOB 18 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 19 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 20 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 21 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 22 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 23 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 24 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 25 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nandrdy: ebi-nandrdy-0 {
+						atmel,pins =
+							<AT91_PIOC 16 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nrd_nandoe: ebi-nrd-nandoe-0 {
+						atmel,pins =
+							<AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nwait: ebi-nwait-0 {
+						atmel,pins =
+							<AT91_PIOE 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nwe_nandwe: ebi-nwe-nandwe-0 {
+						atmel,pins =
+							<AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_nwr1_nbs1: ebi-nwr1-nbs1-0 {
+						atmel,pins =
+							<AT91_PIOE 29 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+				};
+
 				i2c0 {
 					pinctrl_i2c0: i2c0-0 {
 						atmel,pins =
-- 
2.7.4
