From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sun, 14 Sep 2014 00:13:24 +0200
Subject: [PATCH 3/7] ARM: dts: add DT for Alpscale ASM9260 SoC
In-Reply-To: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1410646408-28901-4-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/asm9260-devkit.dts |  15 ++
 arch/arm/boot/dts/asm9260.dtsi       | 425 +++++++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+)
 create mode 100644 arch/arm/boot/dts/asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/asm9260.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index adb5ed9..ff75287 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -446,6 +446,8 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
 
+dtb-$(CONFIG_MACH_ASM9260) += asm9260-devkit.dtb
+
 targets += dtbs dtbs_install
 targets += $(dtb-y)
 endif
diff --git a/arch/arm/boot/dts/asm9260-devkit.dts b/arch/arm/boot/dts/asm9260-devkit.dts
new file mode 100644
index 0000000..2cbc391
--- /dev/null
+++ b/arch/arm/boot/dts/asm9260-devkit.dts
@@ -0,0 +1,15 @@
+/dts-v1/;
+#include "asm9260.dtsi"
+
+/ {
+	model = "Alpscale asm9260 Development Kit";
+	compatible = "alpscale,asm9260devkit", "alpscale,asm9260";
+
+	chosen {
+		bootargs = "mem=32M earlyprintk=serial console=ttyS4,115200n8 root=/dev/mtdblock1 init=/linuxrc mtdparts=NAND:4M at 10M(logo)ro,60M at 14M(root)ro";
+	};
+
+};
+&uart4 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/asm9260.dtsi b/arch/arm/boot/dts/asm9260.dtsi
new file mode 100644
index 0000000..52bb8de
--- /dev/null
+++ b/arch/arm/boot/dts/asm9260.dtsi
@@ -0,0 +1,425 @@
+/*
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&icoll>;
+
+        aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+        };
+
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			clocks = <&cpu_div>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+                ranges;
+
+		icoll: interrupt-controller at 80054000 {
+			compatible = "alpscale,asm9260-icall";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x80054000 0x200>;
+		};
+
+		uart0: serial at 80000000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80000000 0x4000>;
+			clocks = <&uart0_div>, <&ahb_uart0_gate>;
+			interrupts = <15>;
+			status = "disabled";
+		};
+		uart1: serial at 80004000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80004000 0x4000>;
+			clocks = <&uart1_div>, <&ahb_uart1_gate>;
+			interrupts = <16>;
+			status = "disabled";
+		};
+		uart2: serial at 80008000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80008000 0x4000>;
+			clocks = <&uart2_div>, <&ahb_uart2_gate>;
+			interrupts = <17>;
+			status = "disabled";
+		};
+		uart3: serial at 8000c000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x8000c000 0x4000>;
+			clocks = <&uart3_div>, <&ahb_uart3_gate>;
+			interrupts = <18>;
+			status = "disabled";
+		};
+		uart4: serial at 80010000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80010000 0x4000>;
+			clocks = <&uart4_div>, <&ahb_uart4_gate>;
+			interrupts = <19>;
+			status = "disabled";
+		};
+		uart5: serial at 80014000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80014000 0x4000>;
+			clocks = <&uart5_div>, <&ahb_uart5_gate>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+		uart6: serial at 80018000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80018000 0x4000>;
+			clocks = <&uart6_div>, <&ahb_uart6_gate>;
+			interrupts = <21>;
+			status = "disabled";
+		};
+		uart7: serial at 8001c000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x8001c000 0x4000>;
+			clocks = <&uart7_div>, <&ahb_uart7_gate>;
+			interrupts = <22>;
+			status = "disabled";
+		};
+		uart8: serial at 80020000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80020000 0x4000>;
+			clocks = <&uart8_div>, <&ahb_uart8_gate>;
+			interrupts = <23>;
+			status = "disabled";
+		};
+		uart9: serial at 80024000 {
+			compatible = "alpscale,asm9260-uart";
+			reg = <0x80024000 0x4000>;
+			clocks = <&uart9_div>, <&ahb_uart9_gate>;
+			interrupts = <24>;
+			status = "disabled";
+		};
+
+		/* timers, should be moved after sregs */
+		timer0: timer at 80088000 {
+			compatible = "alpscale,asm9260-timer";
+			reg = <0x80088000 0x4000>;
+			clocks = <&ahb_timer0_gate>;
+			interrupts = <29>;
+			/* status = "disabled"; */
+		};
+
+		sregs at 80040000 {
+			compatible = "alpscale,asm9260-sregs";
+			reg = <0x80040000 0x504>;
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				osc24m: oscillator {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <24000000>;
+					clock-accuracy = <30000>;
+				};
+
+				pll: pll at 0100 {
+					compatible = "alpscale,asm9260-pll-clock";
+					#clock-cells = <0>;
+					clocks = <&osc24m>;
+					reg = <0x0100>;
+				};
+
+				main_mux: main_mux at 0120 {
+					compatible = "alpscale,asm9260-bimux-clock";
+					#clock-cells = <0>;
+					clocks = <&osc24m>, <&pll>;
+					mux-table = <0 1>;
+					reg = <0x0120>;
+				};
+
+				main_gate: main_gate at 0124 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&main_mux>;
+					reg = <0x0124>;
+					bit-index = <0>;
+				};
+
+				cpu_div: cpu_div at 017c {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&main_gate>;
+					reg = <0x017c>;
+				};
+
+				ahb_div: ahb_div at 0180 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&cpu_div>;
+					reg = <0x0180>;
+				};
+
+				/* ahb devices start */
+
+/*
+				ahb_rom_gate: ahb_rom_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <1>;
+				};
+				ahb_ram_gate: ahb_ram_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <2>;
+				};
+				ahb_gpio_gate: ahb_gpio_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <4>;
+				};
+				ahb_mac_gate: ahb_mac_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <5>;
+				};
+				ahb_emi_gate: ahb_emi_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <6>;
+				};
+
+*/
+				ahb_usb0_gate: ahb_usb0_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <7>;
+				};
+				ahb_usb1_gate: ahb_usb1_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <8>;
+				};
+
+/*
+				ahb_dma0_gate: ahb_dma0_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <9>;
+				};
+				ahb_dma1_gate: ahb_dma1_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <10>;
+				};
+
+*/
+				ahb_uart0_gate: ahb_uart0_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <11>;
+				};
+				ahb_uart1_gate: ahb_uart1_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <12>;
+				};
+				ahb_uart2_gate: ahb_uart2_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <13>;
+				};
+				ahb_uart3_gate: ahb_uart3_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <14>;
+				};
+
+				ahb_uart4_gate: ahb_uart4_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <15>;
+				};
+
+				ahb_uart5_gate: ahb_uart5_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <16>;
+				};
+				ahb_uart6_gate: ahb_uart6_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <17>;
+				};
+				ahb_uart7_gate: ahb_uart7_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <18>;
+				};
+
+				ahb_uart8_gate: ahb_uart8_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <19>;
+				};
+				ahb_uart9_gate: ahb_uart9_gate at 0020 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0020>;
+					bit-index = <20>;
+				};
+
+				ahb_timer0_gate: ahb_timer0_gate at 0030 {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&ahb_div>;
+					reg = <0x0030>;
+					bit-index = <4>;
+				};
+
+
+
+				/* ahb devices end */
+
+				/* uart related clocks */
+				uart_mux: uart_mux at 0128 {
+					compatible = "alpscale,asm9260-bimux-clock";
+					#clock-cells = <0>;
+					clocks = <&osc24m>, <&pll>;
+					mux-table = <0 1>;
+					reg = <0x0128>;
+				};
+				uart_gate: uart_gate at 012c {
+					compatible = "alpscale,asm9260-gate-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_mux>;
+					reg = <0x012c>;
+					bit-index = <0>;
+				};
+				uart0_div: uart0_div at 0198 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x0198>;
+				};
+				uart1_div: uart1_div at 019c {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x019c>;
+				};
+				uart2_div: uart2_div at 01a0 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01a0>;
+				};
+				uart3_div: uart3_div at 01a4 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01a4>;
+				};
+				uart4_div: uart4_div at 01a8 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01a8>;
+				};
+				uart5_div: uart5_div at 01ac {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01ac>;
+				};
+				uart6_div: uart6_div at 01b0 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01b0>;
+				};
+				uart7_div: uart7_div at 01b4 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01b4>;
+				};
+				uart8_div: uart8_div at 01b8 {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01b8>;
+				};
+				uart9_div: uart9_div at 01bc {
+					compatible = "alpscale,asm9260-div-clock";
+					#clock-cells = <0>;
+					clocks = <&uart_gate>;
+					reg = <0x01bc>;
+				};
+				/* end of uart section */
+
+
+			};
+		};
+	};
+};
-- 
1.9.1
