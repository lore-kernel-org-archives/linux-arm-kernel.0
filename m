From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  4 May 2012 23:26:02 +0800
Subject: [PATCH 1/2 RESEND] ARM: mxs: add initial device tree support for
 imx23-evk board
In-Reply-To: <1336139444-24672-1-git-send-email-shawn.guo@linaro.org>
References: <1336139444-24672-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336145162-3642-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds initial device tree support for imx23-evk board, and only
serial console is enabled.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Resend to add missing dts files

 Documentation/devicetree/bindings/arm/fsl.txt |    4 +
 arch/arm/boot/dts/imx23-evk.dts               |   22 +++
 arch/arm/boot/dts/imx23.dtsi                  |  232 +++++++++++++++++++++++++
 arch/arm/mach-mxs/Kconfig                     |    1 +
 arch/arm/mach-mxs/clock-mx23.c                |    2 +
 arch/arm/mach-mxs/mach-mxs.c                  |   24 +++
 6 files changed, 285 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx23-evk.dts
 create mode 100644 arch/arm/boot/dts/imx23.dtsi

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index fecb580..1708df5 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -1,6 +1,10 @@
 Freescale i.MX Platforms Device Tree Bindings
 -----------------------------------------------
 
+i.MX23 Evaluation Kit
+Required root node properties:
+    - compatible = "fsl,imx23-evk", "fsl,imx23";
+
 i.MX28 Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx28-evk", "fsl,imx28";
diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
new file mode 100644
index 0000000..05fc530
--- /dev/null
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx23.dtsi"
+
+/ {
+	model = "Freescale i.MX23 Evaluation Kit";
+	compatible = "fsl,imx23-evk", "fsl,imx23";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
new file mode 100644
index 0000000..7761ed0
--- /dev/null
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -0,0 +1,232 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&icoll>;
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	apb at 80000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x80000000 0x80000>;
+		ranges;
+
+		apbh at 80000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80000000 0x40000>;
+			ranges;
+
+			icoll: interrupt-controller at 80000000 {
+				compatible = "fsl,imx23-icoll", "fsl,mxs-icoll";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x80000000 0x2000>;
+			};
+
+			dma-apbh at 80004000 {
+				reg = <0x80004000 2000>;
+				status = "disabled";
+			};
+
+			ecc at 80008000 {
+				reg = <0x80008000 2000>;
+				status = "disabled";
+			};
+
+			bch at 8000a000 {
+				reg = <0x8000a000 2000>;
+				status = "disabled";
+			};
+
+			gpmi at 8000c000 {
+				reg = <0x8000c000 2000>;
+				status = "disabled";
+			};
+
+			ssp1: ssp at 80010000 {
+				reg = <0x80010000 2000>;
+				status = "disabled";
+			};
+
+			etm at 80014000 {
+				reg = <0x80014000 2000>;
+				status = "disabled";
+			};
+
+			pinctrl at 80018000 {
+				reg = <0x80018000 2000>;
+				status = "disabled";
+			};
+
+			digctl at 8001c000 {
+				reg = <0x8001c000 2000>;
+				status = "disabled";
+			};
+
+			emi at 80020000 {
+				reg = <0x80020000 2000>;
+				status = "disabled";
+			};
+
+			dma-apbx at 80024000 {
+				reg = <0x80024000 2000>;
+				status = "disabled";
+			};
+
+			dcp at 80028000 {
+				reg = <0x80028000 2000>;
+				status = "disabled";
+			};
+
+			pxp at 8002a000 {
+				reg = <0x8002a000 2000>;
+				status = "disabled";
+			};
+
+			ocotp at 8002c000 {
+				reg = <0x8002c000 2000>;
+				status = "disabled";
+			};
+
+			axi-ahb at 8002e000 {
+				reg = <0x8002e000 2000>;
+				status = "disabled";
+			};
+
+			lcdif at 80030000 {
+				reg = <0x80030000 2000>;
+				status = "disabled";
+			};
+
+			ssp2: ssp at 80034000 {
+				reg = <0x80034000 2000>;
+				status = "disabled";
+			};
+
+			tvenc at 80038000 {
+				reg = <0x80038000 2000>;
+				status = "disabled";
+			};
+                };
+
+		apbx at 80040000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80040000 0x40000>;
+			ranges;
+
+			clkctl at 80040000 {
+				reg = <0x80040000 2000>;
+				status = "disabled";
+			};
+
+			saif1: saif at 80042000 {
+				reg = <0x80042000 2000>;
+				status = "disabled";
+			};
+
+			power at 80044000 {
+				reg = <0x80044000 2000>;
+				status = "disabled";
+			};
+
+			saif2: saif at 80046000 {
+				reg = <0x80046000 2000>;
+				status = "disabled";
+			};
+
+			audio-out at 80048000 {
+				reg = <0x80048000 2000>;
+				status = "disabled";
+			};
+
+			audio-in at 8004c000 {
+				reg = <0x8004c000 2000>;
+				status = "disabled";
+			};
+
+			lradc at 80050000 {
+				reg = <0x80050000 2000>;
+				status = "disabled";
+			};
+
+			spdif at 80054000 {
+				reg = <0x80054000 2000>;
+				status = "disabled";
+			};
+
+			i2c at 80058000 {
+				reg = <0x80058000 2000>;
+				status = "disabled";
+			};
+
+			rtc at 8005c000 {
+				reg = <0x8005c000 2000>;
+				status = "disabled";
+			};
+
+			pwm at 80064000 {
+				reg = <0x80064000 2000>;
+				status = "disabled";
+			};
+
+			timrot at 80068000 {
+				reg = <0x80068000 2000>;
+				status = "disabled";
+			};
+
+			auart1: serial at 8006c000 {
+				reg = <0x8006c000 0x2000>;
+				status = "disabled";
+			};
+
+			auart2: serial at 8006e000 {
+				reg = <0x8006e000 0x2000>;
+				status = "disabled";
+			};
+
+			duart: serial at 80070000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x80070000 0x2000>;
+				interrupts = <0>;
+			};
+
+			usbphy at 8007c000 {
+				reg = <0x8007c000 0x2000>;
+				status = "disabled";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x80080000 0x80000>;
+		ranges;
+
+		usbctrl at 80080000 {
+			reg = <0x80080000 0x10000>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 09fe0fb..a37cfc3 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -21,6 +21,7 @@ comment "MXS platforms:"
 
 config MACH_MXS_DT
 	bool "Support MXS platforms from device tree"
+	select SOC_IMX23
 	select SOC_IMX28
 	select USE_OF
 	help
diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index e3ac52c..23652df 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -440,6 +440,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
 	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
 	_REGISTER_CLOCK("imx23-gpmi-nand", NULL, gpmi_clk)
+	/* for DT */
+	_REGISTER_CLOCK("80070000.serial", NULL, uart_clk)
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 5c5cba2..ae07c9d 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -37,6 +37,15 @@ static void __init mxs_dt_init_irq(void)
 	of_irq_init(mxs_irq_match);
 }
 
+static void __init imx23_timer_init(void)
+{
+	mx23_clocks_init();
+}
+
+static struct sys_timer imx23_timer = {
+	.init = imx23_timer_init,
+};
+
 static void __init imx28_timer_init(void)
 {
 	mx28_clocks_init();
@@ -52,12 +61,27 @@ static void __init mxs_machine_init(void)
 				NULL, NULL);
 }
 
+static const char *imx23_dt_compat[] __initdata = {
+	"fsl,imx23-evk",
+	"fsl,imx23",
+	NULL,
+};
+
 static const char *imx28_dt_compat[] __initdata = {
 	"fsl,imx28-evk",
 	"fsl,imx28",
 	NULL,
 };
 
+DT_MACHINE_START(IMX23, "Freescale i.MX23 (Device Tree)")
+	.map_io		= mx23_map_io,
+	.init_irq	= mxs_dt_init_irq,
+	.timer		= &imx23_timer,
+	.init_machine	= mxs_machine_init,
+	.dt_compat	= imx23_dt_compat,
+	.restart	= mxs_restart,
+MACHINE_END
+
 DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
 	.map_io		= mx28_map_io,
 	.init_irq	= mxs_dt_init_irq,
-- 
1.7.5.4
