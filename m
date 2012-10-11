From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 12 Oct 2012 00:05:26 +0200
Subject: [PATCH 4/4] ARM: AT91: Add AT91RM9200 device tree
In-Reply-To: <1349993126-9519-1-git-send-email-manabian@gmail.com>
References: <1349993126-9519-1-git-send-email-manabian@gmail.com>
Message-ID: <1349993126-9519-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 218 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91rm9200.dtsi

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
new file mode 100644
index 0000000..81a344c
--- /dev/null
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -0,0 +1,218 @@
+/*
+ * at91rm9200.dtsi - Device Tree Include file for AT91RM9200 family SoC
+ *
+ *  Copyright (C) 2011 Atmel,
+ *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>,
+ *                2012 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Based on at91sam9260.dtsi
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Atmel AT91RM9200 family SoC";
+	compatible = "atmel,at91rm9200";
+	interrupt-parent = <&aic>;
+
+	aliases {
+		serial0 = &dbgu;
+		serial1 = &usart0;
+		serial2 = &usart1;
+		serial3 = &usart2;
+		serial4 = &usart3;
+		gpio0 = &pioA;
+		gpio1 = &pioB;
+		gpio2 = &pioC;
+		gpio3 = &pioD;
+		tcb0 = &tcb0;
+		tcb1 = &tcb1;
+	};
+	cpus {
+		cpu at 0 {
+			compatible = "arm,arm920t";
+		};
+	};
+
+	memory {
+		reg = <0x20000000 0x04000000>;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			aic: interrupt-controller at fffff000 {
+				#interrupt-cells = <3>;
+				compatible = "atmel,at91rm9200-aic";
+				interrupt-controller;
+				reg = <0xfffff000 0x200>;
+				atmel,external-irqs = <25 26 27 28 29 30 31>;
+			};
+
+			ramc0: ramc at ffffff00 {
+				compatible = "atmel,at91rm9200-sdramc";
+				reg = <0xffffff00 0x100>;
+			};
+
+			pmc: pmc at fffffc00 {
+				compatible = "atmel,at91rm9200-pmc";
+				reg = <0xfffffc00 0x100>;
+			};
+
+			st: timer at fffffd00 {
+				compatible = "atmel,at91rm9200-st";
+				reg = <0xfffffd00 0x100>;
+				interrupts = <1 4 7>;
+			};
+
+			tcb0: timer at fffa0000 {
+				compatible = "atmel,at91rm9200-tcb";
+				reg = <0xfffa0000 0x100>;
+				interrupts = <17 4 0 18 4 0 19 4 0>;
+			};
+
+			tcb1: timer at fffa4000 {
+				compatible = "atmel,at91rm9200-tcb";
+				reg = <0xfffa4000 0x100>;
+				interrupts = <20 4 0 21 4 0 22 4 0>;
+			};
+
+			pioA: gpio at fffff400 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff400 0x100>;
+				interrupts = <2 4 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pioB: gpio at fffff600 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff600 0x100>;
+				interrupts = <3 4 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pioC: gpio at fffff800 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff800 0x100>;
+				interrupts = <4 4 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pioD: gpio at fffffa00 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffffa00 0x100>;
+				interrupts = <5 4 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			dbgu: serial at fffff200 {
+				compatible = "atmel,at91rm9200-usart";
+				reg = <0xfffff200 0x200>;
+				interrupts = <1 4 7>;
+				status = "disabled";
+			};
+
+			usart0: serial at fffc0000 {
+				compatible = "atmel,at91rm9200-usart";
+				reg = <0xfffc0000 0x200>;
+				interrupts = <6 4 5>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
+			usart1: serial at fffc4000 {
+				compatible = "atmel,at91rm9200-usart";
+				reg = <0xfffc4000 0x200>;
+				interrupts = <7 4 5>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
+			usart2: serial at fffc8000 {
+				compatible = "atmel,at91rm9200-usart";
+				reg = <0xfffc8000 0x200>;
+				interrupts = <8 4 5>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
+			usart3: serial at fffcc000 {
+				compatible = "atmel,at91rm9200-usart";
+				reg = <0xfffcc000 0x200>;
+				interrupts = <23 4 5>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
+			usb1: gadget at fffb0000 {
+				compatible = "atmel,at91rm9200-udc";
+				reg = <0xfffb0000 0x4000>;
+				interrupts = <11 4 2>;
+				status = "disabled";
+			};
+		};
+
+		nand0: nand at 40000000 {
+			compatible = "atmel,at91rm9200-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x40000000 0x10000000>;
+			atmel,nand-addr-offset = <21>;
+			atmel,nand-cmd-offset = <22>;
+			nand-ecc-mode = "soft";
+			gpios = <&pioC 2 0
+				 0
+				 &pioB 1 0
+				>;
+			status = "disabled";
+		};
+
+		usb0: ohci at 00300000 {
+			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+			reg = <0x00300000 0x100000>;
+			interrupts = <23 4 2>;
+			status = "disabled";
+		};
+	};
+
+	i2c at 0 {
+		compatible = "i2c-gpio";
+		gpios = <&pioA 23 0 /* sda */
+			 &pioA 24 0 /* scl */
+			>;
+		i2c-gpio,sda-open-drain;
+		i2c-gpio,scl-open-drain;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+};
-- 
1.7.12.2
