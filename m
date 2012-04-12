From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 12 Apr 2012 10:54:37 +0530
Subject: [PATCH V3 4/4] SPEAr3xx: Add pinctrl support for boards
In-Reply-To: <cover.1334207964.git.viresh.kumar@st.com>
References: <cover.1334207964.git.viresh.kumar@st.com>
Message-ID: <81b04bd4fe751633802e539d724facce80e600a4.1334207964.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/boot/dts/spear300-evb.dts |   38 ++++++++++++++++++++++
 arch/arm/boot/dts/spear300.dtsi    |    5 +++
 arch/arm/boot/dts/spear310-evb.dts |   61 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/spear310.dtsi    |    5 +++
 arch/arm/boot/dts/spear320-evb.dts |   61 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/spear320.dtsi    |    7 +++-
 arch/arm/mach-spear3xx/Kconfig     |    3 ++
 arch/arm/plat-spear/Kconfig        |    1 +
 8 files changed, 180 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
index eaecc29..48a848a 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -25,6 +25,44 @@
 	};
 
 	ahb {
+		pinmux at 99000000 {
+			st,pinmux-mode=<2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&state_default>;
+
+			state_default: pinmux {
+				i2c0 {
+					st,pins = "i2c0_grp";
+					st,function = "i2c0";
+				};
+				ssp0 {
+					st,pins = "ssp0_grp";
+					st,function = "ssp0";
+				};
+				mii0 {
+					st,pins = "mii0_grp";
+					st,function = "mii0";
+				};
+				uart0 {
+					st,pins = "uart0_grp";
+					st,function = "uart0";
+				};
+				clcd {
+					st,pins = "clcd_pfmode_grp";
+					st,function = "clcd";
+				};
+				sdhci {
+					st,pins = "sdhci_4bit_grp";
+					st,function = "sdhci";
+				};
+				gpio1 {
+					st,pins = "gpio1_4_to_7_grp",
+						"gpio1_0_to_3_grp";
+					st,function = "gpio1";
+				};
+			};
+		};
+
 		clcd at 60000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
index f9fcbf4..01c5e35 100644
--- a/arch/arm/boot/dts/spear300.dtsi
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -21,6 +21,11 @@
 		ranges = <0x60000000 0x60000000 0x50000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
+		pinmux at 99000000 {
+			compatible = "st,spear300-pinmux";
+			reg = <0x99000000 0x1000>;
+		};
+
 		clcd at 60000000 {
 			compatible = "arm,clcd-pl110", "arm,primecell";
 			reg = <0x60000000 0x1000>;
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
index c86af33..6d95317 100644
--- a/arch/arm/boot/dts/spear310-evb.dts
+++ b/arch/arm/boot/dts/spear310-evb.dts
@@ -25,6 +25,67 @@
 	};
 
 	ahb {
+		pinmux at b4000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&state_default>;
+
+			state_default: pinmux {
+				gpio0 {
+					st,pins = "gpio0_pin0_grp",
+						"gpio0_pin1_grp",
+						"gpio0_pin2_grp",
+						"gpio0_pin3_grp",
+						"gpio0_pin4_grp",
+						"gpio0_pin5_grp";
+					st,function = "gpio0";
+				};
+				i2c0 {
+					st,pins = "i2c0_grp";
+					st,function = "i2c0";
+				};
+				mii0 {
+					st,pins = "mii0_grp";
+					st,function = "mii0";
+				};
+				ssp0 {
+					st,pins = "ssp0_grp";
+					st,function = "ssp0";
+				};
+				uart0 {
+					st,pins = "uart0_grp";
+					st,function = "uart0";
+				};
+				emi {
+					st,pins = "emi_cs_0_to_5_grp";
+					st,function = "emi";
+				};
+				fsmc {
+					st,pins = "fsmc_grp";
+					st,function = "fsmc";
+				};
+				uart1 {
+					st,pins = "uart1_grp";
+					st,function = "uart1";
+				};
+				uart2 {
+					st,pins = "uart2_grp";
+					st,function = "uart2";
+				};
+				uart3 {
+					st,pins = "uart3_grp";
+					st,function = "uart3";
+				};
+				uart4 {
+					st,pins = "uart4_grp";
+					st,function = "uart4";
+				};
+				uart5 {
+					st,pins = "uart5_grp";
+					st,function = "uart5";
+				};
+			};
+		};
+
 		dma at fc400000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index dc7fa14..e47081c 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -22,6 +22,11 @@
 			  0xb0000000 0xb0000000 0x10000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
+		pinmux at b4000000 {
+			compatible = "st,spear310-pinmux";
+			reg = <0xb4000000 0x1000>;
+		};
+
 		fsmc: flash at 44000000 {
 			compatible = "st,spear600-fsmc-nand";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index d43de71..27fc556 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -25,6 +25,67 @@
 	};
 
 	ahb {
+		pinmux at b3000000 {
+			st,pinmux-mode=<3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&state_default>;
+
+			state_default: pinmux {
+				i2c0 {
+					st,pins = "i2c0_grp";
+					st,function = "i2c0";
+				};
+				mii0 {
+					st,pins = "mii0_grp";
+					st,function = "mii0";
+				};
+				ssp0 {
+					st,pins = "ssp0_grp";
+					st,function = "ssp0";
+				};
+				uart0 {
+					st,pins = "uart0_grp";
+					st,function = "uart0";
+				};
+				sdhci {
+					st,pins = "sdhci_cd_51_grp";
+					st,function = "sdhci";
+				};
+				i2s {
+					st,pins = "i2s_grp";
+					st,function = "i2s";
+				};
+				uart1 {
+					st,pins = "uart1_grp";
+					st,function = "uart1";
+				};
+				uart2 {
+					st,pins = "uart2_grp";
+					st,function = "uart2";
+				};
+				can0 {
+					st,pins = "can0_grp";
+					st,function = "can0";
+				};
+				can1 {
+					st,pins = "can1_grp";
+					st,function = "can1";
+				};
+				mii2 {
+					st,pins = "mii2_grp";
+					st,function = "mii2";
+				};
+				pwm0_1 {
+					st,pins = "pwm0_1_pin_14_15_grp";
+					st,function = "pwm0_1";
+				};
+				pwm2 {
+					st,pins = "pwm2_pin_13_grp";
+					st,function = "pwm2";
+				};
+			};
+		};
+
 		clcd at 90000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 9a0267a..5372ca3 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -18,9 +18,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		ranges = <0x40000000 0x40000000 0x70000000
+		ranges = <0x40000000 0x40000000 0x80000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
+		pinmux at b3000000 {
+			compatible = "st,spear320-pinmux";
+			reg = <0xb3000000 0x1000>;
+		};
+
 		clcd at 90000000 {
 			compatible = "arm,clcd-pl110", "arm,primecell";
 			reg = <0x90000000 0x1000>;
diff --git a/arch/arm/mach-spear3xx/Kconfig b/arch/arm/mach-spear3xx/Kconfig
index d9fe11c..8bd3729 100644
--- a/arch/arm/mach-spear3xx/Kconfig
+++ b/arch/arm/mach-spear3xx/Kconfig
@@ -7,16 +7,19 @@ if ARCH_SPEAR3XX
 menu "SPEAr3xx Implementations"
 config MACH_SPEAR300
 	bool "SPEAr300 Machine support with Device Tree"
+	select PINCTRL_SPEAR300
 	help
 	  Supports ST SPEAr300 machine configured via the device-tree
 
 config MACH_SPEAR310
 	bool "SPEAr310 Machine support with Device Tree"
+	select PINCTRL_SPEAR310
 	help
 	  Supports ST SPEAr310 machine configured via the device-tree
 
 config MACH_SPEAR320
 	bool "SPEAr320 Machine support with Device Tree"
+	select PINCTRL_SPEAR320
 	help
 	  Supports ST SPEAr320 machine configured via the device-tree
 endmenu
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 6c066fc..387655b 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -13,6 +13,7 @@ config ARCH_SPEAR3XX
 	select ARM_VIC
 	select CPU_ARM926T
 	select USE_OF
+	select PINCTRL
 	help
 	  Supports for ARM's SPEAR3XX family
 
-- 
1.7.9
