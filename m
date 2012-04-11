From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 Apr 2012 18:01:11 +0200
Subject: [PATCH 1/9] ARM: at91: add at91sam9260 DT support
In-Reply-To: <20120411153515.GK16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
Message-ID: <1334160079-30831-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91sam9260 and at91sam9g20 share most of the same IP.
So udpate the node property in the at91sam9g20 only.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 .../dts/{at91sam9g20.dtsi => at91sam9260.dtsi}     |    8 +-
 arch/arm/boot/dts/at91sam9g20.dtsi                 |  257 ++------------------
 arch/arm/mach-at91/Makefile.boot                   |    1 +
 3 files changed, 23 insertions(+), 243 deletions(-)
 rename arch/arm/boot/dts/{at91sam9g20.dtsi => at91sam9260.dtsi} (96%)
 rewrite arch/arm/boot/dts/at91sam9g20.dtsi (95%)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
similarity index 96%
rename from arch/arm/boot/dts/at91sam9g20.dtsi
rename to arch/arm/boot/dts/at91sam9260.dtsi
index 799ad18..71c78d1 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -1,5 +1,5 @@
 /*
- * at91sam9g20.dtsi - Device Tree Include file for AT91SAM9G20 family SoC
+ * at91sam9260.dtsi - Device Tree Include file for AT91SAM9260 family SoC
  *
  *  Copyright (C) 2011 Atmel,
  *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>,
@@ -11,8 +11,8 @@
 /include/ "skeleton.dtsi"
 
 / {
-	model = "Atmel AT91SAM9G20 family SoC";
-	compatible = "atmel,at91sam9g20";
+	model = "Atmel AT91SAM9260 family SoC";
+	compatible = "atmel,at91sam9260";
 	interrupt-parent = <&aic>;
 
 	aliases {
@@ -36,7 +36,7 @@
 	};
 
 	memory {
-		reg = <0x20000000 0x08000000>;
+		reg = <0x20000000 0x04000000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
dissimilarity index 95%
index 799ad18..0eb1a75 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -1,239 +1,18 @@
-/*
- * at91sam9g20.dtsi - Device Tree Include file for AT91SAM9G20 family SoC
- *
- *  Copyright (C) 2011 Atmel,
- *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>,
- *                2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * Licensed under GPLv2 or later.
- */
-
-/include/ "skeleton.dtsi"
-
-/ {
-	model = "Atmel AT91SAM9G20 family SoC";
-	compatible = "atmel,at91sam9g20";
-	interrupt-parent = <&aic>;
-
-	aliases {
-		serial0 = &dbgu;
-		serial1 = &usart0;
-		serial2 = &usart1;
-		serial3 = &usart2;
-		serial4 = &usart3;
-		serial5 = &usart4;
-		serial6 = &usart5;
-		gpio0 = &pioA;
-		gpio1 = &pioB;
-		gpio2 = &pioC;
-		tcb0 = &tcb0;
-		tcb1 = &tcb1;
-	};
-	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
-		};
-	};
-
-	memory {
-		reg = <0x20000000 0x08000000>;
-	};
-
-	ahb {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		apb {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			aic: interrupt-controller at fffff000 {
-				#interrupt-cells = <2>;
-				compatible = "atmel,at91rm9200-aic";
-				interrupt-controller;
-				interrupt-parent;
-				reg = <0xfffff000 0x200>;
-			};
-
-			ramc0: ramc at ffffea00 {
-				compatible = "atmel,at91sam9260-sdramc";
-				reg = <0xffffea00 0x200>;
-			};
-
-			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91rm9200-pmc";
-				reg = <0xfffffc00 0x100>;
-			};
-
-			rstc at fffffd00 {
-				compatible = "atmel,at91sam9260-rstc";
-				reg = <0xfffffd00 0x10>;
-			};
-
-			shdwc at fffffd10 {
-				compatible = "atmel,at91sam9260-shdwc";
-				reg = <0xfffffd10 0x10>;
-			};
-
-			pit: timer at fffffd30 {
-				compatible = "atmel,at91sam9260-pit";
-				reg = <0xfffffd30 0xf>;
-				interrupts = <1 4>;
-			};
-
-			tcb0: timer at fffa0000 {
-				compatible = "atmel,at91rm9200-tcb";
-				reg = <0xfffa0000 0x100>;
-				interrupts = <17 4 18 4 19 4>;
-			};
-
-			tcb1: timer at fffdc000 {
-				compatible = "atmel,at91rm9200-tcb";
-				reg = <0xfffdc000 0x100>;
-				interrupts = <26 4 27 4 28 4>;
-			};
-
-			pioA: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <2 4>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioB: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <3 4>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioC: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <4 4>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			dbgu: serial at fffff200 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xfffff200 0x200>;
-				interrupts = <1 4>;
-				status = "disabled";
-			};
-
-			usart0: serial at fffb0000 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xfffb0000 0x200>;
-				interrupts = <6 4>;
-				atmel,use-dma-rx;
-				atmel,use-dma-tx;
-				status = "disabled";
-			};
-
-			usart1: serial at fffb4000 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xfffb4000 0x200>;
-				interrupts = <7 4>;
-				atmel,use-dma-rx;
-				atmel,use-dma-tx;
-				status = "disabled";
-			};
-
-			usart2: serial at fffb8000 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xfffb8000 0x200>;
-				interrupts = <8 4>;
-				atmel,use-dma-rx;
-				atmel,use-dma-tx;
-				status = "disabled";
-			};
-
-			usart3: serial at fffd0000 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xfffd0000 0x200>;
-				interrupts = <23 4>;
-				atmel,use-dma-rx;
-				atmel,use-dma-tx;
-				status = "disabled";
-			};
-
-			usart4: serial at fffd4000 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xfffd4000 0x200>;
-				interrupts = <24 4>;
-				atmel,use-dma-rx;
-				atmel,use-dma-tx;
-				status = "disabled";
-			};
-
-			usart5: serial at fffd8000 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xfffd8000 0x200>;
-				interrupts = <25 4>;
-				atmel,use-dma-rx;
-				atmel,use-dma-tx;
-				status = "disabled";
-			};
-
-			macb0: ethernet at fffc4000 {
-				compatible = "cdns,at32ap7000-macb", "cdns,macb";
-				reg = <0xfffc4000 0x100>;
-				interrupts = <21 4>;
-				status = "disabled";
-			};
-
-			usb1: gadget at fffa4000 {
-				compatible = "atmel,at91rm9200-udc";
-				reg = <0xfffa4000 0x4000>;
-				interrupts = <10 4>;
-				status = "disabled";
-			};
-		};
-
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000
-			       0xffffe800 0x200
-			      >;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			gpios = <&pioC 13 0
-				 &pioC 14 0
-				 0
-				>;
-			status = "disabled";
-		};
-
-		usb0: ohci at 00500000 {
-			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
-			reg = <0x00500000 0x100000>;
-			interrupts = <20 4>;
-			status = "disabled";
-		};
-	};
-
-	i2c at 0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 23 0 /* sda */
-			 &pioA 24 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-};
+/*
+ * at91sam9g20.dtsi - Device Tree Include file for AT91SAM9G20 family SoC
+ *
+ *  Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2.
+ */
+
+/include/ "at91sam9260.dtsi"
+
+/ {
+	model = "Atmel AT91SAM9G20 family SoC";
+	compatible = "atmel,at91sam9g20";
+
+	memory {
+		reg = <0x20000000 0x08000000>;
+	};
+};
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 0da66ca..0c2336c 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -14,6 +14,7 @@ initrd_phys-y	:= 0x20410000
 endif
 
 # Keep dtb files sorted alphabetically for each SoC
+# sam9260
 # sam9g20
 dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9g20.dtb
 # sam9g45
-- 
1.7.9.1
