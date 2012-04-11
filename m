From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 Apr 2012 18:01:18 +0200
Subject: [PATCH 8/9] ARM: at91: add at91sam9263 DT support
In-Reply-To: <20120411153515.GK16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
Message-ID: <1334160079-30831-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi       |  221 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9263.c         |   10 ++
 arch/arm/mach-at91/at91sam9263_devices.c |   20 +++
 3 files changed, 251 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9263.dtsi

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
new file mode 100644
index 0000000..baecf52
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -0,0 +1,221 @@
+/*
+ * at91sam9263.dtsi - Device Tree Include file for AT91SAM9263 family SoC
+ *
+ *  Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Atmel AT91SAM9263 family SoC";
+	compatible = "atmel,at91sam9263";
+	interrupt-parent = <&aic>;
+
+	aliases {
+		serial0 = &dbgu;
+		serial1 = &usart0;
+		serial2 = &usart1;
+		serial3 = &usart2;
+		gpio0 = &pioA;
+		gpio1 = &pioB;
+		gpio2 = &pioC;
+		gpio3 = &pioD;
+		gpio4 = &pioE;
+		tcb0 = &tcb0;
+	};
+	cpus {
+		cpu at 0 {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	memory {
+		reg = <0x20000000 0x08000000>;
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
+				#interrupt-cells = <2>;
+				compatible = "atmel,at91rm9200-aic";
+				interrupt-controller;
+				interrupt-parent;
+				reg = <0xfffff000 0x200>;
+			};
+
+			pmc: pmc at fffffc00 {
+				compatible = "atmel,at91rm9200-pmc";
+				reg = <0xfffffc00 0x100>;
+			};
+
+			ramc: ramc at ffffe200 {
+				compatible = "atmel,at91sam9260-sdramc";
+				reg = <0xffffe200 0x200
+				       0xffffe800 0x200>;
+			};
+
+			pit: timer at fffffd30 {
+				compatible = "atmel,at91sam9260-pit";
+				reg = <0xfffffd30 0xf>;
+				interrupts = <1 4>;
+			};
+
+			tcb0: timer at fff7c000 {
+				compatible = "atmel,at91rm9200-tcb";
+				reg = <0xfff7c000 0x100>;
+				interrupts = <19 4>;
+			};
+
+			rstc at fffffd00 {
+				compatible = "atmel,at91sam9260-rstc";
+				reg = <0xfffffd00 0x10>;
+			};
+
+			shdwc at fffffd10 {
+				compatible = "atmel,at91sam9260-shdwc";
+				reg = <0xfffffd10 0x10>;
+			};
+
+			pioA: gpio at fffff200 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff200 0x100>;
+				interrupts = <2 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			pioB: gpio at fffff400 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff400 0x100>;
+				interrupts = <3 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			pioC: gpio at fffff600 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff600 0x100>;
+				interrupts = <4 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			pioD: gpio at fffff800 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff800 0x100>;
+				interrupts = <4 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			pioE: gpio at fffffa00 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffffa00 0x100>;
+				interrupts = <4 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			dbgu: serial at ffffee00 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xffffee00 0x200>;
+				interrupts = <1 4>;
+				status = "disabled";
+			};
+
+			usart0: serial at fff8c000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfff8c000 0x200>;
+				interrupts = <7 4>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
+			usart1: serial at fff90000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfff90000 0x200>;
+				interrupts = <8 4>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
+			usart2: serial at fff94000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfff94000 0x200>;
+				interrupts = <9 4>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
+			macb0: ethernet at fffbc000 {
+				compatible = "cdns,at32ap7000-macb", "cdns,macb";
+				reg = <0xfffbc000 0x100>;
+				interrupts = <21 4>;
+				status = "disabled";
+			};
+
+			usb1: gadget at fff78000 {
+				compatible = "atmel,at91rm9200-udc";
+				reg = <0xfff78000 0x4000>;
+				interrupts = <24 4>;
+				status = "disabled";
+			};
+		};
+
+		nand0: nand at 40000000 {
+			compatible = "atmel,at91rm9200-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x40000000 0x10000000
+			       0xffffe000 0x200
+			      >;
+			atmel,nand-addr-offset = <21>;
+			atmel,nand-cmd-offset = <22>;
+			gpios = <&pioA 22 0
+				 &pioD 15 0
+				 0
+				>;
+			status = "disabled";
+		};
+
+		usb0: ohci at 00a00000 {
+			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+			reg = <0x00a00000 0x100000>;
+			interrupts = <29 4>;
+			status = "disabled";
+		};
+	};
+
+	i2c at 0 {
+		compatible = "i2c-gpio";
+		gpios = <&pioB 4 0 /* sda */
+			 &pioB 5 0 /* scl */
+			>;
+		i2c-gpio,sda-open-drain;
+		i2c-gpio,scl-open-drain;
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 7fae365..ed91c7e 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -199,6 +199,16 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_ID("pioC", &pioCDE_clk),
 	CLKDEV_CON_ID("pioD", &pioCDE_clk),
 	CLKDEV_CON_ID("pioE", &pioCDE_clk),
+	/* more usart lookup table for DT entries */
+	CLKDEV_CON_DEV_ID("usart", "ffffee00.serial", &mck),
+	CLKDEV_CON_DEV_ID("usart", "fff8c000.serial", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "fff90000.serial", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "fff94000.serial", &usart2_clk),
+	/* more tc lookup table for DT entries */
+	CLKDEV_CON_DEV_ID("t0_clk", "fff7c000.timer", &tcb_clk),
+	CLKDEV_CON_DEV_ID("hclk", "a00000.ohci", &ohci_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index dfe5bc0..175e000 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -953,8 +953,25 @@ static struct platform_device at91sam9263_tcb_device = {
 	.num_resources	= ARRAY_SIZE(tcb_resources),
 };
 
+#if defined(CONFIG_OF)
+static struct of_device_id tcb_ids[] = {
+	{ .compatible = "atmel,at91rm9200-tcb" },
+	{ /*sentinel*/ }
+};
+#endif
+
 static void __init at91_add_device_tc(void)
 {
+#if defined(CONFIG_OF)
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, tcb_ids);
+	if (np) {
+		of_node_put(np);
+		return;
+	}
+#endif
+
 	platform_device_register(&at91sam9263_tcb_device);
 }
 #else
@@ -1483,6 +1500,9 @@ void __init at91_add_device_serial(void) {}
  */
 static int __init at91_add_standard_devices(void)
 {
+	if (of_have_populated_dt())
+		return 0;
+
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	at91_add_device_tc();
-- 
1.7.9.1
