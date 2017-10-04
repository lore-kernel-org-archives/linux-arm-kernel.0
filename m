From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 17:19:11 +1030
Subject: [PATCH v2 3/9] ARM: dts: aspeed: Add I2C buses
In-Reply-To: <20171004064917.2498-1-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
Message-ID: <20171004064917.2498-4-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now with an upstream i2c bus driver, we can add  the 14 i2c buses that
exist in ASPEED G4 and G5 generation SoCs.

It also adds aliases for the 14 built-in I2C busses to ensure userspace
sees the numbering staring from zero and counting up.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 256 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 256 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 512 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c2d96b8a5065..b6ae7b62fd03 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -7,6 +7,23 @@
 	#size-cells = <1>;
 	interrupt-parent = <&vic>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -235,10 +252,249 @@
 				no-loopback-test;
 				status = "disabled";
 			};
+
+			i2c: i2c at 1e78a000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e78a000 0x1000>;
+			};
 		};
 	};
 };
 
+&i2c {
+	i2c_ic: interrupt-controller at 0 {
+		#interrupt-cells = <1>;
+		compatible = "aspeed,ast2400-i2c-ic";
+		reg = <0x0 0x40>;
+		interrupts = <12>;
+		interrupt-controller;
+	};
+
+	i2c0: i2c-bus at 40 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x40 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <0>;
+		interrupt-parent = <&i2c_ic>;
+		status = "disabled";
+		/* Does not need pinctrl properties */
+	};
+
+	i2c1: i2c-bus at 80 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x80 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <1>;
+		interrupt-parent = <&i2c_ic>;
+		status = "disabled";
+		/* Does not need pinctrl properties */
+	};
+
+	i2c2: i2c-bus at c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0xc0 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <2>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3_default>;
+		status = "disabled";
+	};
+
+	i2c3: i2c-bus at 100 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x100 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <3>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c4_default>;
+		status = "disabled";
+	};
+
+	i2c4: i2c-bus at 140 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x140 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <4>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c5_default>;
+		status = "disabled";
+	};
+
+	i2c5: i2c-bus at 180 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x180 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <5>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c6_default>;
+		status = "disabled";
+	};
+
+	i2c6: i2c-bus at 1c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x1c0 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <6>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c7_default>;
+		status = "disabled";
+	};
+
+	i2c7: i2c-bus at 300 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x300 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <7>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c8_default>;
+		status = "disabled";
+	};
+
+	i2c8: i2c-bus at 340 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x340 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <8>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c9_default>;
+		status = "disabled";
+	};
+
+	i2c9: i2c-bus at 380 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x380 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <9>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c10_default>;
+		status = "disabled";
+	};
+
+	i2c10: i2c-bus at 3c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x3c0 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <10>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c11_default>;
+		status = "disabled";
+	};
+
+	i2c11: i2c-bus at 400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x400 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <11>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c12_default>;
+		status = "disabled";
+	};
+
+	i2c12: i2c-bus at 440 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x440 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <12>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c13_default>;
+		status = "disabled";
+	};
+
+	i2c13: i2c-bus at 480 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x480 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <13>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c14_default>;
+		status = "disabled";
+	};
+};
+
 &pinctrl {
 	pinctrl_acpi_default: acpi_default {
 		function = "ACPI";
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 9e71c2dac0ba..4c829e915c3e 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -7,6 +7,23 @@
 	#size-cells = <1>;
 	interrupt-parent = <&vic>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -315,10 +332,249 @@
 				no-loopback-test;
 				status = "disabled";
 			};
+
+			i2c: i2c at 1e78a000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e78a000 0x1000>;
+			};
 		};
 	};
 };
 
+&i2c {
+	i2c_ic: interrupt-controller at 0 {
+		#interrupt-cells = <1>;
+		compatible = "aspeed,ast2500-i2c-ic";
+		reg = <0x0 0x40>;
+		interrupts = <12>;
+		interrupt-controller;
+	};
+
+	i2c0: i2c-bus at 40 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x40 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <0>;
+		interrupt-parent = <&i2c_ic>;
+		status = "disabled";
+		/* Does not need pinctrl properties */
+	};
+
+	i2c1: i2c-bus at 80 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x80 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <1>;
+		interrupt-parent = <&i2c_ic>;
+		status = "disabled";
+		/* Does not need pinctrl properties */
+	};
+
+	i2c2: i2c-bus at c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0xc0 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <2>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3_default>;
+		status = "disabled";
+	};
+
+	i2c3: i2c-bus at 100 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x100 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <3>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c4_default>;
+		status = "disabled";
+	};
+
+	i2c4: i2c-bus at 140 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x140 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <4>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c5_default>;
+		status = "disabled";
+	};
+
+	i2c5: i2c-bus at 180 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x180 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <5>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c6_default>;
+		status = "disabled";
+	};
+
+	i2c6: i2c-bus at 1c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x1c0 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <6>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c7_default>;
+		status = "disabled";
+	};
+
+	i2c7: i2c-bus at 300 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x300 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <7>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c8_default>;
+		status = "disabled";
+	};
+
+	i2c8: i2c-bus at 340 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x340 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <8>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c9_default>;
+		status = "disabled";
+	};
+
+	i2c9: i2c-bus at 380 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x380 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <9>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c10_default>;
+		status = "disabled";
+	};
+
+	i2c10: i2c-bus at 3c0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x3c0 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <10>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c11_default>;
+		status = "disabled";
+	};
+
+	i2c11: i2c-bus at 400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x400 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <11>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c12_default>;
+		status = "disabled";
+	};
+
+	i2c12: i2c-bus at 440 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x440 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <12>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c13_default>;
+		status = "disabled";
+	};
+
+	i2c13: i2c-bus at 480 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x480 0x40>;
+		compatible = "aspeed,ast2500-i2c-bus";
+		clocks = <&clk_apb>;
+		bus-frequency = <100000>;
+		interrupts = <13>;
+		interrupt-parent = <&i2c_ic>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c14_default>;
+		status = "disabled";
+	};
+};
+
 &pinctrl {
 	pinctrl_acpi_default: acpi_default {
 		function = "ACPI";
-- 
2.14.1
