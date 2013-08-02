From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 2 Aug 2013 19:16:35 +0530
Subject: [PATCH 2/2] ARM: dts: AM4372: add few nodes
In-Reply-To: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
Message-ID: <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate uarts, timers, rtc, wdt, gpio, i2c, spi, cpsw & pwm nodes.

Reason for adding these nodes early - hwmod code required address
space of peripherals corresponding to these nodes (as address space
details are removed from hwmod database).

uart0, timers - 1 & 2 and synctimer were already present, so here the
remaining uarts & timers are added.

All properties as per the existing binding has been added for uart,
timer, rtc, wdt & gpio. Even though that was not the current scope
of work, felt adding those would reduce or require no effort later
to get these peripherals working.

For i2c, spi, cpsw & pwm - only the properties that were sure to be
correct has been added (main intention is to make hwmod happy and
avoid any later modification to here added properties).

While at it add "ti,hwmod" property to already existing nodes.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |  343 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 343 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 4635e7f..0fe393a 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -49,6 +49,47 @@
 			compatible = "ti,am4372-uart","ti,omap2-uart";
 			reg = <0x44e09000 0x2000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "uart1";
+		};
+
+		uart1: serial at 48022000 {
+			compatible = "ti,am4372-uart","ti,omap2-uart";
+			reg = <0x48022000 0x2000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "uart2";
+			status = "disabled";
+		};
+
+		uart2: serial at 48024000 {
+			compatible = "ti,am4372-uart","ti,omap2-uart";
+			reg = <0x48024000 0x2000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "uart3";
+			status = "disabled";
+		};
+
+		uart3: serial at 481a6000 {
+			compatible = "ti,am4372-uart","ti,omap2-uart";
+			reg = <0x481a6000 0x2000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "uart4";
+			status = "disabled";
+		};
+
+		uart4: serial at 481a8000 {
+			compatible = "ti,am4372-uart","ti,omap2-uart";
+			reg = <0x481a8000 0x2000>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "uart5";
+			status = "disabled";
+		};
+
+		uart5: serial at 481aa000 {
+			compatible = "ti,am4372-uart","ti,omap2-uart";
+			reg = <0x481aa000 0x2000>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "uart6";
+			status = "disabled";
 		};
 
 		timer1: timer at 44e31000 {
@@ -56,17 +97,319 @@
 			reg = <0x44e31000 0x400>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-alwon;
+			ti,hwmods = "timer1";
 		};
 
 		timer2: timer at 48040000  {
 			compatible = "ti,am4372-timer","ti,am335x-timer";
 			reg = <0x48040000  0x400>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer at 48042000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x48042000 0x400>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer3";
+			status = "disabled";
+		};
+
+		timer4: timer at 48044000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x48044000 0x400>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			ti,timer-pwm;
+			ti,hwmods = "timer4";
+			status = "disabled";
+		};
+
+		timer5: timer at 48046000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x48046000 0x400>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			ti,timer-pwm;
+			ti,hwmods = "timer5";
+			status = "disabled";
+		};
+
+		timer6: timer at 48048000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x48048000 0x400>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			ti,timer-pwm;
+			ti,hwmods = "timer6";
+			status = "disabled";
+		};
+
+		timer7: timer at 4804a000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x4804a000 0x400>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			ti,timer-pwm;
+			ti,hwmods = "timer7";
+			status = "disabled";
+		};
+
+		timer8: timer at 481c1000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x481c1000 0x400>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer8";
+			status = "disabled";
+		};
+
+		timer9: timer at 4833d000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x4833d000 0x400>;
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer9";
+			status = "disabled";
+		};
+
+		timer10: timer at 4833f000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x4833f000 0x400>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer10";
+			status = "disabled";
+		};
+
+		timer11: timer at 48341000 {
+			compatible = "ti,am4372-timer","ti,am335x-timer";
+			reg = <0x48341000 0x400>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer11";
+			status = "disabled";
 		};
 
 		counter32k: counter at 44e86000 {
 			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
 			reg = <0x44e86000 0x40>;
+			ti,hwmods = "counter_32k";
+		};
+
+		rtc at 44e3e000 {
+			compatible = "ti,am4372-rtc","ti,da830-rtc";
+			reg = <0x44e3e000 0x1000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "rtc";
+			status = "disabled";
+		};
+
+		wdt at 44e35000 {
+			compatible = "ti,am4372-wdt","ti,omap3-wdt";
+			reg = <0x44e35000 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "wd_timer2";
+			status = "disabled";
+		};
+
+		gpio0: gpio at 44e07000 {
+			compatible = "ti,am4372-gpio","ti,omap4-gpio";
+			reg = <0x44e07000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,hwmods = "gpio1";
+			status = "disabled";
+		};
+
+		gpio1: gpio at 4804c000 {
+			compatible = "ti,am4372-gpio","ti,omap4-gpio";
+			reg = <0x4804c000 0x1000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,hwmods = "gpio2";
+			status = "disabled";
+		};
+
+		gpio2: gpio at 481ac000 {
+			compatible = "ti,am4372-gpio","ti,omap4-gpio";
+			reg = <0x481ac000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,hwmods = "gpio3";
+			status = "disabled";
+		};
+
+		gpio3: gpio at 481ae000 {
+			compatible = "ti,am4372-gpio","ti,omap4-gpio";
+			reg = <0x481ae000 0x1000>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,hwmods = "gpio4";
+			status = "disabled";
+		};
+
+		gpio4: gpio at 48320000 {
+			compatible = "ti,am4372-gpio","ti,omap4-gpio";
+			reg = <0x48320000 0x1000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,hwmods = "gpio5";
+			status = "disabled";
+		};
+
+		gpio5: gpio at 48322000 {
+			compatible = "ti,am4372-gpio","ti,omap4-gpio";
+			reg = <0x48322000 0x1000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,hwmods = "gpio6";
+			status = "disabled";
+		};
+
+		i2c0: i2c at 44e0b000 {
+			compatible = "ti,am4372-i2c","ti,omap4-i2c";
+			reg = <0x44e0b000 0x1000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "i2c1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 4802a000 {
+			compatible = "ti,am4372-i2c","ti,omap4-i2c";
+			reg = <0x4802a000 0x1000>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "i2c2";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 4819c000 {
+			compatible = "ti,am4372-i2c","ti,omap4-i2c";
+			reg = <0x4819c000 0x1000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "i2c3";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi0: spi at 48030000 {
+			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+			reg = <0x48030000 0x400>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "spi0";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi at 481a0000 {
+			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+			reg = <0x481a0000 0x400>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "spi1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi at 481a2000 {
+			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+			reg = <0x481a2000 0x400>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "spi2";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi3: spi at 481a4000 {
+			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+			reg = <0x481a4000 0x400>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "spi3";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi4: spi at 48345000 {
+			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+			reg = <0x48345000 0x400>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "spi4";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		mac: ethernet at 4a100000 {
+			compatible = "ti,am4372-cpsw","ti,cpsw";
+			reg = <0x4a100000 0x800
+			       0x4a101200 0x100>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "cpgmac0";
+			status = "disabled";
+		};
+
+		epwmss0: epwmss at 48300000 {
+			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+			reg = <0x48300000 0x10>;
+			ti,hwmods = "epwmss0";
+			status = "disabled";
+		};
+
+		epwmss1: epwmss at 48302000 {
+			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+			reg = <0x48302000 0x10>;
+			ti,hwmods = "epwmss1";
+			status = "disabled";
+		};
+
+		epwmss2: epwmss at 48304000 {
+			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+			reg = <0x48304000 0x10>;
+			ti,hwmods = "epwmss2";
+			status = "disabled";
+		};
+
+		epwmss3: epwmss at 48306000 {
+			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+			reg = <0x48306000 0x10>;
+			ti,hwmods = "epwmss3";
+			status = "disabled";
+		};
+
+		epwmss4: epwmss at 48308000 {
+			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+			reg = <0x48308000 0x10>;
+			ti,hwmods = "epwmss4";
+			status = "disabled";
+		};
+
+		epwmss5: epwmss at 4830a000 {
+			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+			reg = <0x4830a000 0x10>;
+			ti,hwmods = "epwmss5";
+			status = "disabled";
 		};
 	};
 };
-- 
1.7.9.5
