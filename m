From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 23:18:12 +0200
Subject: [PATCH 1/4] ARM: at91: add at91sam9g20 dtsi
In-Reply-To: <20111016210819.GM1459@game.jcrosoft.org>
References: <20111016210819.GM1459@game.jcrosoft.org>
Message-ID: <1318799895-5121-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi |  154 ++++++++++++++++++++++++++++++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9g20.dtsi

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
new file mode 100644
index 0000000..d6afa5f
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -0,0 +1,154 @@
+/*
+ * at91sam9g20.dtsi - Device Tree Include file for AT91SAM9G20 family SoC
+ *
+ *  Copyright (C) 2011 Atmel,
+ *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *                2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Atmel AT91SAM9G20 family SoC";
+	compatible = "atmel,at91sam9g20";
+	interrupt-parent = <&aic>;
+
+	aliases {
+		serial0 = &dbgu;
+		serial1 = &usart0;
+		serial2 = &usart1;
+		serial3 = &usart2;
+		serial4 = &usart3;
+		serial5 = &usart4;
+		serial6 = &usart5;
+	};
+	cpus {
+		cpu at 0 {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	memory at 20000000 {
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
+				#interrupt-cells = <1>;
+				compatible = "atmel,at91rm9200-aic";
+				interrupt-controller;
+				interrupt-parent;
+				reg = <0xfffff000 0x200>;
+			};
+
+			dbgu: serial at fffff200 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfffff200 0x200>;
+				interrupts = <1>;
+			};
+
+			usart0: serial at fffb0000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfffb0000 0x200>;
+				interrupts = <6>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+			};
+
+			usart1: serial at fffb4000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfffb4000 0x200>;
+				interrupts = <7>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+			};
+
+			usart2: serial at fffb8000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfffb8000 0x200>;
+				interrupts = <8>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+			};
+
+			usart3: serial at fffd0000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfffd0000 0x200>;
+				interrupts = <23>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+			};
+
+			usart4: serial at fffd4000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfffd4000 0x200>;
+				interrupts = <24>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+			};
+
+			usart5: serial at fffd8000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfffd8000 0x200>;
+				interrupts = <25>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+			};
+
+/*
+			smc0: smc at ffffec00 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+
+			smc1: smc at ffffec10 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+
+			smc2: smc at ffffec20 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+
+			smc3: smc at ffffec30 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+
+			smc4: smc at ffffec40 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+
+			smc5: smc at ffffec50 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+
+			smc6: smc at ffffec60 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+
+			smc7: smc at ffffec70 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec00 0x10>;
+			};
+*/
+		};
+	};
+};
-- 
1.7.7
