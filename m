From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:20 +0200
Subject: [PATCH v2 04/15] ARM: dts: rockchip: remove soc subnodes
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comments received from the rk3288 submission indicated that a generic subnode
to group soc components should not be used.

So to keep all rockchip devicetree files similar, remove it from rk3066 and rk3188.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 134 ++++++-----
 arch/arm/boot/dts/rk3066a.dtsi         | 390 ++++++++++++++++-----------------
 arch/arm/boot/dts/rk3188-radxarock.dts |  83 ++++---
 arch/arm/boot/dts/rk3188.dtsi          | 334 ++++++++++++++--------------
 arch/arm/boot/dts/rk3xxx.dtsi          | 221 +++++++++----------
 5 files changed, 573 insertions(+), 589 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index afb3273..6131675 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -24,87 +24,85 @@
 		reg = <0x60000000 0x40000000>;
 	};
 
-	soc {
-		uart0: serial at 10124000 {
-			status = "okay";
-		};
+	uart0: serial at 10124000 {
+		status = "okay";
+	};
 
-		uart1: serial at 10126000 {
-			status = "okay";
-		};
+	uart1: serial at 10126000 {
+		status = "okay";
+	};
 
-		uart2: serial at 20064000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart2_xfer>;
-			status = "okay";
-		};
+	uart2: serial at 20064000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart2_xfer>;
+		status = "okay";
+	};
 
-		uart3: serial at 20068000 {
-			status = "okay";
-		};
+	uart3: serial at 20068000 {
+		status = "okay";
+	};
 
-		vcc_sd0: fixed-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "sdmmc-supply";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-			gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
-			startup-delay-us = <100000>;
-		};
+	vcc_sd0: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "sdmmc-supply";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <100000>;
+	};
 
-		dwmmc at 10214000 { /* sdmmc */
-			num-slots = <1>;
-			status = "okay";
+	dwmmc at 10214000 { /* sdmmc */
+		num-slots = <1>;
+		status = "okay";
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
-			vmmc-supply = <&vcc_sd0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
+		vmmc-supply = <&vcc_sd0>;
 
-			slot at 0 {
-				reg = <0>;
-				bus-width = <4>;
-				disable-wp;
-			};
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+			disable-wp;
 		};
+	};
 
-		dwmmc at 10218000 { /* wifi */
-			num-slots = <1>;
-			status = "okay";
-			non-removable;
+	dwmmc at 10218000 { /* wifi */
+		num-slots = <1>;
+		status = "okay";
+		non-removable;
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
 
-			slot at 0 {
-				reg = <0>;
-				bus-width = <4>;
-				disable-wp;
-			};
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+			disable-wp;
 		};
+	};
 
-		gpio-keys {
-			compatible = "gpio-keys";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			autorepeat;
-
-			button at 0 {
-				gpios = <&gpio6 2 GPIO_ACTIVE_LOW>; /* GPIO6_A2 */
-				linux,code = <116>;
-				label = "GPIO Key Power";
-				linux,input-type = <1>;
-				gpio-key,wakeup = <1>;
-				debounce-interval = <100>;
-			};
-			button at 1 {
-				gpios = <&gpio4 21 GPIO_ACTIVE_LOW>; /* GPIO4_C5 */
-				linux,code = <104>;
-				label = "GPIO Key Vol-";
-				linux,input-type = <1>;
-				gpio-key,wakeup = <0>;
-				debounce-interval = <100>;
-			};
-			/* VOL+ comes somehow thru the ADC */
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		button at 0 {
+			gpios = <&gpio6 2 GPIO_ACTIVE_LOW>; /* GPIO6_A2 */
+			linux,code = <116>;
+			label = "GPIO Key Power";
+			linux,input-type = <1>;
+			gpio-key,wakeup = <1>;
+			debounce-interval = <100>;
+		};
+		button at 1 {
+			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>; /* GPIO4_C5 */
+			linux,code = <104>;
+			label = "GPIO Key Vol-";
+			linux,input-type = <1>;
+			gpio-key,wakeup = <0>;
+			debounce-interval = <100>;
 		};
+		/* VOL+ comes somehow thru the ADC */
 	};
 };
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 6476ce7..4ad8f59 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -40,255 +40,253 @@
 		};
 	};
 
-	soc {
-		timer at 20038000 {
-			compatible = "snps,dw-apb-timer-osc";
-			reg = <0x20038000 0x100>;
-			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru SCLK_TIMER0>, <&cru PCLK_TIMER0>;
-			clock-names = "timer", "pclk";
-		};
+	timer at 20038000 {
+		compatible = "snps,dw-apb-timer-osc";
+		reg = <0x20038000 0x100>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TIMER0>, <&cru PCLK_TIMER0>;
+		clock-names = "timer", "pclk";
+	};
+
+	timer at 2003a000 {
+		compatible = "snps,dw-apb-timer-osc";
+		reg = <0x2003a000 0x100>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TIMER1>, <&cru PCLK_TIMER1>;
+		clock-names = "timer", "pclk";
+	};
+
+	timer at 2000e000 {
+		compatible = "snps,dw-apb-timer-osc";
+		reg = <0x2000e000 0x100>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TIMER2>, <&cru PCLK_TIMER2>;
+		clock-names = "timer", "pclk";
+	};
 
-		timer at 2003a000 {
-			compatible = "snps,dw-apb-timer-osc";
-			reg = <0x2003a000 0x100>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru SCLK_TIMER1>, <&cru PCLK_TIMER1>;
-			clock-names = "timer", "pclk";
+	sram: sram at 10080000 {
+		compatible = "mmio-sram";
+		reg = <0x10080000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x10080000 0x10000>;
+
+		smp-sram at 0 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x0 0x50>;
 		};
+	};
+
+	cru: clock-controller at 20000000 {
+		compatible = "rockchip,rk3066a-cru";
+		reg = <0x20000000 0x1000>;
+		rockchip,grf = <&grf>;
+
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pinctrl at 20008000 {
+		compatible = "rockchip,rk3066a-pinctrl";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
 
-		timer at 2000e000 {
-			compatible = "snps,dw-apb-timer-osc";
-			reg = <0x2000e000 0x100>;
-			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru SCLK_TIMER2>, <&cru PCLK_TIMER2>;
-			clock-names = "timer", "pclk";
+		gpio0: gpio0 at 20034000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20034000 0x100>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO0>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
-		sram: sram at 10080000 {
-			compatible = "mmio-sram";
-			reg = <0x10080000 0x10000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x10080000 0x10000>;
+		gpio1: gpio1 at 2003c000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x2003c000 0x100>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO1>;
 
-			smp-sram at 0 {
-				compatible = "rockchip,rk3066-smp-sram";
-				reg = <0x0 0x50>;
-			};
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
-		cru: clock-controller at 20000000 {
-			compatible = "rockchip,rk3066a-cru";
-			reg = <0x20000000 0x1000>;
-			rockchip,grf = <&grf>;
+		gpio2: gpio2 at 2003e000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x2003e000 0x100>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO2>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
 
-			#clock-cells = <1>;
-			#reset-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
-		pinctrl at 20008000 {
-			compatible = "rockchip,rk3066a-pinctrl";
-			rockchip,grf = <&grf>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+		gpio3: gpio3 at 20080000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20080000 0x100>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO3>;
 
-			gpio0: gpio0 at 20034000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x20034000 0x100>;
-				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO0>;
+			gpio-controller;
+			#gpio-cells = <2>;
 
-				gpio-controller;
-				#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+		gpio4: gpio4 at 20084000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20084000 0x100>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO4>;
 
-			gpio1: gpio1 at 2003c000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x2003c000 0x100>;
-				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO1>;
+			gpio-controller;
+			#gpio-cells = <2>;
 
-				gpio-controller;
-				#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+		gpio6: gpio6 at 2000a000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x2000a000 0x100>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO6>;
 
-			gpio2: gpio2 at 2003e000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x2003e000 0x100>;
-				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO2>;
+			gpio-controller;
+			#gpio-cells = <2>;
 
-				gpio-controller;
-				#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+		pcfg_pull_default: pcfg_pull_default {
+			bias-pull-pin-default;
+		};
 
-			gpio3: gpio3 at 20080000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x20080000 0x100>;
-				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO3>;
+		pcfg_pull_none: pcfg_pull_none {
+			bias-disable;
+		};
 
-				gpio-controller;
-				#gpio-cells = <2>;
+		uart0 {
+			uart0_xfer: uart0-xfer {
+				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
+			uart0_cts: uart0-cts {
+				rockchip,pins = <RK_GPIO1 2 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			gpio4: gpio4 at 20084000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x20084000 0x100>;
-				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO4>;
+			uart0_rts: uart0-rts {
+				rockchip,pins = <RK_GPIO1 3 RK_FUNC_1 &pcfg_pull_default>;
+			};
+		};
 
-				gpio-controller;
-				#gpio-cells = <2>;
+		uart1 {
+			uart1_xfer: uart1-xfer {
+				rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
+			uart1_cts: uart1-cts {
+				rockchip,pins = <RK_GPIO1 6 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			gpio6: gpio6 at 2000a000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x2000a000 0x100>;
-				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO6>;
+			uart1_rts: uart1-rts {
+				rockchip,pins = <RK_GPIO1 7 RK_FUNC_1 &pcfg_pull_default>;
+			};
+		};
 
-				gpio-controller;
-				#gpio-cells = <2>;
+		uart2 {
+			uart2_xfer: uart2-xfer {
+				rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_default>;
+			};
+			/* no rts / cts for uart2 */
+		};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
+		uart3 {
+			uart3_xfer: uart3-xfer {
+				rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO3 28 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			pcfg_pull_default: pcfg_pull_default {
-				bias-pull-pin-default;
+			uart3_cts: uart3-cts {
+				rockchip,pins = <RK_GPIO3 29 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			pcfg_pull_none: pcfg_pull_none {
-				bias-disable;
+			uart3_rts: uart3-rts {
+				rockchip,pins = <RK_GPIO3 30 RK_FUNC_1 &pcfg_pull_default>;
 			};
+		};
 
-			uart0 {
-				uart0_xfer: uart0-xfer {
-					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_default>;
-				};
+		sd0 {
+			sd0_clk: sd0-clk {
+				rockchip,pins = <RK_GPIO3 8 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				uart0_cts: uart0-cts {
-					rockchip,pins = <RK_GPIO1 2 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd0_cmd: sd0-cmd {
+				rockchip,pins = <RK_GPIO3 9 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				uart0_rts: uart0-rts {
-					rockchip,pins = <RK_GPIO1 3 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd0_cd: sd0-cd {
+				rockchip,pins = <RK_GPIO3 14 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			uart1 {
-				uart1_xfer: uart1-xfer {
-					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd0_wp: sd0-wp {
+				rockchip,pins = <RK_GPIO3 15 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				uart1_cts: uart1-cts {
-					rockchip,pins = <RK_GPIO1 6 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd0_bus1: sd0-bus-width1 {
+				rockchip,pins = <RK_GPIO3 10 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				uart1_rts: uart1-rts {
-					rockchip,pins = <RK_GPIO1 7 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd0_bus4: sd0-bus-width4 {
+				rockchip,pins = <RK_GPIO3 10 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO3 11 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO3 12 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO3 13 RK_FUNC_1 &pcfg_pull_default>;
 			};
+		};
 
-			uart2 {
-				uart2_xfer: uart2-xfer {
-					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_default>;
-				};
-				/* no rts / cts for uart2 */
+		sd1 {
+			sd1_clk: sd1-clk {
+				rockchip,pins = <RK_GPIO3 21 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			uart3 {
-				uart3_xfer: uart3-xfer {
-					rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO3 28 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd1_cmd: sd1-cmd {
+				rockchip,pins = <RK_GPIO3 16 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				uart3_cts: uart3-cts {
-					rockchip,pins = <RK_GPIO3 29 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd1_cd: sd1-cd {
+				rockchip,pins = <RK_GPIO3 22 RK_FUNC_1 &pcfg_pull_default>;
+			};
 
-				uart3_rts: uart3-rts {
-					rockchip,pins = <RK_GPIO3 30 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd1_wp: sd1-wp {
+				rockchip,pins = <RK_GPIO3 23 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			sd0 {
-				sd0_clk: sd0-clk {
-					rockchip,pins = <RK_GPIO3 8 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd0_cmd: sd0-cmd {
-					rockchip,pins = <RK_GPIO3 9 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd0_cd: sd0-cd {
-					rockchip,pins = <RK_GPIO3 14 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd0_wp: sd0-wp {
-					rockchip,pins = <RK_GPIO3 15 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd0_bus1: sd0-bus-width1 {
-					rockchip,pins = <RK_GPIO3 10 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd0_bus4: sd0-bus-width4 {
-					rockchip,pins = <RK_GPIO3 10 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO3 11 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO3 12 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO3 13 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd1_bus1: sd1-bus-width1 {
+				rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
-			sd1 {
-				sd1_clk: sd1-clk {
-					rockchip,pins = <RK_GPIO3 21 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd1_cmd: sd1-cmd {
-					rockchip,pins = <RK_GPIO3 16 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd1_cd: sd1-cd {
-					rockchip,pins = <RK_GPIO3 22 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd1_wp: sd1-wp {
-					rockchip,pins = <RK_GPIO3 23 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd1_bus1: sd1-bus-width1 {
-					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_default>;
-				};
-
-				sd1_bus4: sd1-bus-width4 {
-					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO3 18 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO3 19 RK_FUNC_1 &pcfg_pull_default>,
-							<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_default>;
-				};
+			sd1_bus4: sd1-bus-width4 {
+				rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO3 18 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO3 19 RK_FUNC_1 &pcfg_pull_default>,
+						<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_default>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index a5eee55..7a002f5 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -23,59 +23,56 @@
 		reg = <0x60000000 0x80000000>;
 	};
 
-	soc {
-		uart0: serial at 10124000 {
-			status = "okay";
-		};
+	uart0: serial at 10124000 {
+		status = "okay";
+	};
 
-		uart1: serial at 10126000 {
-			status = "okay";
-		};
+	uart1: serial at 10126000 {
+		status = "okay";
+	};
 
-		uart2: serial at 20064000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart2_xfer>;
-			status = "okay";
-		};
+	uart2: serial at 20064000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart2_xfer>;
+		status = "okay";
+	};
 
-		uart3: serial at 20068000 {
-			status = "okay";
-		};
+	uart3: serial at 20068000 {
+		status = "okay";
+	};
 
-		gpio-keys {
-			compatible = "gpio-keys";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			autorepeat;
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
 
-			button at 0 {
-				gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
-				linux,code = <116>;
-				label = "GPIO Key Power";
-				linux,input-type = <1>;
-				gpio-key,wakeup = <1>;
-				debounce-interval = <100>;
-			};
+		button at 0 {
+			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+			linux,code = <116>;
+			label = "GPIO Key Power";
+			linux,input-type = <1>;
+			gpio-key,wakeup = <1>;
+			debounce-interval = <100>;
 		};
+	};
 
-		gpio-leds {
-			compatible = "gpio-leds";
-
-			green {
-				gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
-				default-state = "off";
-			};
+	gpio-leds {
+		compatible = "gpio-leds";
 
-			yellow {
-				gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
-				default-state = "off";
-			};
+		green {
+			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
 
-			sleep {
-				gpios = <&gpio0 15 0>;
-				default-state = "off";
-			};
+		yellow {
+			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
+			default-state = "off";
 		};
 
+		sleep {
+			gpios = <&gpio0 15 0>;
+			default-state = "off";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 0db541c..038d9d4 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -52,223 +52,221 @@
 		};
 	};
 
-	soc {
-		global-timer at 1013c200 {
-			interrupts = <GIC_PPI 11 0xf04>;
+	global-timer at 1013c200 {
+		interrupts = <GIC_PPI 11 0xf04>;
+	};
+
+	local-timer at 1013c600 {
+		interrupts = <GIC_PPI 13 0xf04>;
+	};
+
+	sram: sram at 10080000 {
+		compatible = "mmio-sram";
+		reg = <0x10080000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x10080000 0x8000>;
+
+		smp-sram at 0 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x0 0x50>;
 		};
+	};
+
+	cru: clock-controller at 20000000 {
+		compatible = "rockchip,rk3188-cru";
+		reg = <0x20000000 0x1000>;
+		rockchip,grf = <&grf>;
+
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
 
-		local-timer at 1013c600 {
-			interrupts = <GIC_PPI 13 0xf04>;
+	pinctrl at 20008000 {
+		compatible = "rockchip,rk3188-pinctrl";
+		rockchip,grf = <&grf>;
+		rockchip,pmu = <&pmu>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpio0: gpio0 at 0x2000a000 {
+			compatible = "rockchip,rk3188-gpio-bank0";
+			reg = <0x2000a000 0x100>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO0>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
-		sram: sram at 10080000 {
-			compatible = "mmio-sram";
-			reg = <0x10080000 0x8000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x10080000 0x8000>;
+		gpio1: gpio1 at 0x2003c000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x2003c000 0x100>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO1>;
 
-			smp-sram at 0 {
-				compatible = "rockchip,rk3066-smp-sram";
-				reg = <0x0 0x50>;
-			};
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
-		cru: clock-controller at 20000000 {
-			compatible = "rockchip,rk3188-cru";
-			reg = <0x20000000 0x1000>;
-			rockchip,grf = <&grf>;
+		gpio2: gpio2 at 2003e000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x2003e000 0x100>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO2>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
 
-			#clock-cells = <1>;
-			#reset-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
-		pinctrl at 20008000 {
-			compatible = "rockchip,rk3188-pinctrl";
-			rockchip,grf = <&grf>;
-			rockchip,pmu = <&pmu>;
+		gpio3: gpio3 at 20080000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20080000 0x100>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO3>;
 
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+			gpio-controller;
+			#gpio-cells = <2>;
 
-			gpio0: gpio0 at 0x2000a000 {
-				compatible = "rockchip,rk3188-gpio-bank0";
-				reg = <0x2000a000 0x100>;
-				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO0>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
-				gpio-controller;
-				#gpio-cells = <2>;
+		pcfg_pull_up: pcfg_pull_up {
+			bias-pull-up;
+		};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+		pcfg_pull_down: pcfg_pull_down {
+			bias-pull-down;
+		};
 
-			gpio1: gpio1 at 0x2003c000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x2003c000 0x100>;
-				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO1>;
+		pcfg_pull_none: pcfg_pull_none {
+			bias-disable;
+		};
 
-				gpio-controller;
-				#gpio-cells = <2>;
+		uart0 {
+			uart0_xfer: uart0-xfer {
+				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
+						<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
+			uart0_cts: uart0-cts {
+				rockchip,pins = <RK_GPIO1 2 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			gpio2: gpio2 at 2003e000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x2003e000 0x100>;
-				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO2>;
+			uart0_rts: uart0-rts {
+				rockchip,pins = <RK_GPIO1 3 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
 
-				gpio-controller;
-				#gpio-cells = <2>;
+		uart1 {
+			uart1_xfer: uart1-xfer {
+				rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_up>,
+						<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
+			uart1_cts: uart1-cts {
+				rockchip,pins = <RK_GPIO1 6 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			gpio3: gpio3 at 20080000 {
-				compatible = "rockchip,gpio-bank";
-				reg = <0x20080000 0x100>;
-				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cru PCLK_GPIO3>;
+			uart1_rts: uart1-rts {
+				rockchip,pins = <RK_GPIO1 7 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
 
-				gpio-controller;
-				#gpio-cells = <2>;
+		uart2 {
+			uart2_xfer: uart2-xfer {
+				rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_up>,
+						<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_none>;
+			};
+			/* no rts / cts for uart2 */
+		};
 
-				interrupt-controller;
-				#interrupt-cells = <2>;
+		uart3 {
+			uart3_xfer: uart3-xfer {
+				rockchip,pins = <RK_GPIO1 10 RK_FUNC_1 &pcfg_pull_up>,
+						<RK_GPIO1 11 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			pcfg_pull_up: pcfg_pull_up {
-				bias-pull-up;
+			uart3_cts: uart3-cts {
+				rockchip,pins = <RK_GPIO1 12 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			pcfg_pull_down: pcfg_pull_down {
-				bias-pull-down;
+			uart3_rts: uart3-rts {
+				rockchip,pins = <RK_GPIO1 13 RK_FUNC_1 &pcfg_pull_none>;
 			};
+		};
 
-			pcfg_pull_none: pcfg_pull_none {
-				bias-disable;
+		sd0 {
+			sd0_clk: sd0-clk {
+				rockchip,pins = <RK_GPIO3 2 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			uart0 {
-				uart0_xfer: uart0-xfer {
-					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
-							<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd0_cmd: sd0-cmd {
+				rockchip,pins = <RK_GPIO3 3 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				uart0_cts: uart0-cts {
-					rockchip,pins = <RK_GPIO1 2 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd0_cd: sd0-cd {
+				rockchip,pins = <RK_GPIO3 8 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				uart0_rts: uart0-rts {
-					rockchip,pins = <RK_GPIO1 3 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd0_wp: sd0-wp {
+				rockchip,pins = <RK_GPIO3 9 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			uart1 {
-				uart1_xfer: uart1-xfer {
-					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_up>,
-							<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd0_pwr: sd0-pwr {
+				rockchip,pins = <RK_GPIO3 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				uart1_cts: uart1-cts {
-					rockchip,pins = <RK_GPIO1 6 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd0_bus1: sd0-bus-width1 {
+				rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				uart1_rts: uart1-rts {
-					rockchip,pins = <RK_GPIO1 7 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd0_bus4: sd0-bus-width4 {
+				rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 5 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 6 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 7 RK_FUNC_1 &pcfg_pull_none>;
 			};
+		};
 
-			uart2 {
-				uart2_xfer: uart2-xfer {
-					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_up>,
-							<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_none>;
-				};
-				/* no rts / cts for uart2 */
+		sd1 {
+			sd1_clk: sd1-clk {
+				rockchip,pins = <RK_GPIO3 21 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			uart3 {
-				uart3_xfer: uart3-xfer {
-					rockchip,pins = <RK_GPIO1 10 RK_FUNC_1 &pcfg_pull_up>,
-							<RK_GPIO1 11 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd1_cmd: sd1-cmd {
+				rockchip,pins = <RK_GPIO3 16 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				uart3_cts: uart3-cts {
-					rockchip,pins = <RK_GPIO1 12 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd1_cd: sd1-cd {
+				rockchip,pins = <RK_GPIO3 22 RK_FUNC_1 &pcfg_pull_none>;
+			};
 
-				uart3_rts: uart3-rts {
-					rockchip,pins = <RK_GPIO1 13 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd1_wp: sd1-wp {
+				rockchip,pins = <RK_GPIO3 23 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			sd0 {
-				sd0_clk: sd0-clk {
-					rockchip,pins = <RK_GPIO3 2 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd0_cmd: sd0-cmd {
-					rockchip,pins = <RK_GPIO3 3 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd0_cd: sd0-cd {
-					rockchip,pins = <RK_GPIO3 8 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd0_wp: sd0-wp {
-					rockchip,pins = <RK_GPIO3 9 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd0_pwr: sd0-pwr {
-					rockchip,pins = <RK_GPIO3 1 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd0_bus1: sd0-bus-width1 {
-					rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd0_bus4: sd0-bus-width4 {
-					rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>,
-							<RK_GPIO3 5 RK_FUNC_1 &pcfg_pull_none>,
-							<RK_GPIO3 6 RK_FUNC_1 &pcfg_pull_none>,
-							<RK_GPIO3 7 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd1_bus1: sd1-bus-width1 {
+				rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			sd1 {
-				sd1_clk: sd1-clk {
-					rockchip,pins = <RK_GPIO3 21 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd1_cmd: sd1-cmd {
-					rockchip,pins = <RK_GPIO3 16 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd1_cd: sd1-cd {
-					rockchip,pins = <RK_GPIO3 22 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd1_wp: sd1-wp {
-					rockchip,pins = <RK_GPIO3 23 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd1_bus1: sd1-bus-width1 {
-					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_none>;
-				};
-
-				sd1_bus4: sd1-bus-width4 {
-					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_none>,
-							<RK_GPIO3 18 RK_FUNC_1 &pcfg_pull_none>,
-							<RK_GPIO3 19 RK_FUNC_1 &pcfg_pull_none>,
-							<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_none>;
-				};
+			sd1_bus4: sd1-bus-width4 {
+				rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 18 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 19 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 6d16364..f70addd 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -27,120 +27,113 @@
 		clock-output-names = "xin24m";
 	};
 
-	soc {
+	scu at 1013c000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x1013c000 0x100>;
+	};
+
+	pmu: pmu at 20004000 {
+		compatible = "rockchip,rk3066-pmu", "syscon";
+		reg = <0x20004000 0x100>;
+	};
+
+	grf: grf at 20008000 {
+		compatible = "syscon";
+		reg = <0x20008000 0x200>;
+	};
+
+	gic: interrupt-controller at 1013d000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x1013d000 0x1000>,
+		      <0x1013c100 0x0100>;
+	};
+
+	L2: l2-cache-controller at 10138000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x10138000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	global-timer at 1013c200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x1013c200 0x20>;
+		interrupts = <GIC_PPI 11 0x304>;
+		clocks = <&cru CORE_PERI>;
+	};
+
+	local-timer at 1013c600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x1013c600 0x20>;
+		interrupts = <GIC_PPI 13 0x304>;
+		clocks = <&cru CORE_PERI>;
+	};
+
+	uart0: serial at 10124000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x10124000 0x400>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <1>;
+		clocks = <&cru SCLK_UART0>;
+		status = "disabled";
+	};
+
+	uart1: serial at 10126000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x10126000 0x400>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <1>;
+		clocks = <&cru SCLK_UART1>;
+		status = "disabled";
+	};
+
+	uart2: serial at 20064000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x20064000 0x400>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <1>;
+		clocks = <&cru SCLK_UART2>;
+		status = "disabled";
+	};
+
+	uart3: serial at 20068000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x20068000 0x400>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <1>;
+		clocks = <&cru SCLK_UART3>;
+		status = "disabled";
+	};
+
+	dwmmc at 10214000 {
+		compatible = "rockchip,rk2928-dw-mshc";
+		reg = <0x10214000 0x1000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		ranges;
-
-		scu at 1013c000 {
-			compatible = "arm,cortex-a9-scu";
-			reg = <0x1013c000 0x100>;
-		};
-
-		pmu: pmu at 20004000 {
-			compatible = "rockchip,rk3066-pmu", "syscon";
-			reg = <0x20004000 0x100>;
-		};
-
-		grf: grf at 20008000 {
-			compatible = "syscon";
-			reg = <0x20008000 0x200>;
-		};
-
-		gic: interrupt-controller at 1013d000 {
-			compatible = "arm,cortex-a9-gic";
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			reg = <0x1013d000 0x1000>,
-			      <0x1013c100 0x0100>;
-		};
-
-		L2: l2-cache-controller at 10138000 {
-			compatible = "arm,pl310-cache";
-			reg = <0x10138000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
-		};
-
-		global-timer at 1013c200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x1013c200 0x20>;
-			interrupts = <GIC_PPI 11 0x304>;
-			clocks = <&cru CORE_PERI>;
-		};
-
-		local-timer at 1013c600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x1013c600 0x20>;
-			interrupts = <GIC_PPI 13 0x304>;
-			clocks = <&cru CORE_PERI>;
-		};
-
-		uart0: serial at 10124000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x10124000 0x400>;
-			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART0>;
-			status = "disabled";
-		};
-
-		uart1: serial at 10126000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x10126000 0x400>;
-			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART1>;
-			status = "disabled";
-		};
-
-		uart2: serial at 20064000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x20064000 0x400>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART2>;
-			status = "disabled";
-		};
-
-		uart3: serial at 20068000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x20068000 0x400>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART3>;
-			status = "disabled";
-		};
-
-		dwmmc at 10214000 {
-			compatible = "rockchip,rk2928-dw-mshc";
-			reg = <0x10214000 0x1000>;
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
-			clock-names = "biu", "ciu";
-
-			status = "disabled";
-		};
-
-		dwmmc at 10218000 {
-			compatible = "rockchip,rk2928-dw-mshc";
-			reg = <0x10218000 0x1000>;
-			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
-			clock-names = "biu", "ciu";
-
-			status = "disabled";
-		};
+		#size-cells = <0>;
+
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
+		clock-names = "biu", "ciu";
+
+		status = "disabled";
+	};
+
+	dwmmc at 10218000 {
+		compatible = "rockchip,rk2928-dw-mshc";
+		reg = <0x10218000 0x1000>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
+		clock-names = "biu", "ciu";
+
+		status = "disabled";
 	};
 };
-- 
2.0.1
