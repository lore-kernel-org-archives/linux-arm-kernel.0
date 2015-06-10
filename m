From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 10 Jun 2015 17:04:59 +0200
Subject: [RESEND PROTO] ARM: at91/dt: proto dt
In-Reply-To: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1433948699-19800-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Conflicts:
	arch/arm/boot/dts/Makefile
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/at91-sama5d4ek_proto.dts | 243 ++++++++++
 arch/arm/boot/dts/sama5d4_proto-pinfunc.h  | 463 +++++++++++++++++++
 arch/arm/boot/dts/sama5d4_proto.dtsi       | 716 +++++++++++++++++++++++++++++
 4 files changed, 1423 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d4ek_proto.dts
 create mode 100644 arch/arm/boot/dts/sama5d4_proto-pinfunc.h
 create mode 100644 arch/arm/boot/dts/sama5d4_proto.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 83a4e68..cc63345 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -45,6 +45,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	sama5d35ek.dtb \
 	sama5d36ek.dtb \
 	at91-sama5d4_xplained.dtb \
+	at91-sama5d4ek_proto.dtb \
 	at91-sama5d4ek.dtb
 dtb-$(CONFIG_ARCH_ATLAS6) += \
 	atlas6-evb.dtb
diff --git a/arch/arm/boot/dts/at91-sama5d4ek_proto.dts b/arch/arm/boot/dts/at91-sama5d4ek_proto.dts
new file mode 100644
index 0000000..24d92d3
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d4ek_proto.dts
@@ -0,0 +1,243 @@
+/*
+ * at91-sama5d4ek.dts - Device Tree file for SAMA5D4 Evaluation Kit
+ *
+ *  Copyright (C) 2014 Atmel,
+ *                2014 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+/dts-v1/;
+#include "sama5d4_proto.dtsi"
+
+/ {
+	model = "Atmel SAMA5D4-EK";
+	compatible = "atmel,sama5d4ek", "atmel,sama5d4", "atmel,sama5";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 ignore_loglevel earlyprintk";
+	};
+
+	memory {
+		reg = <0x20000000 0x20000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			pinctrl at fc06a000 {
+				group_defs {
+					mac0_0_rmii {
+						pins = <PIN_PB0__G0_TXCK>,
+						       <PIN_PB2__G0_TXEN>,
+						       <PIN_PB6__G0_RXDV>,
+						       <PIN_PB7__G0_RXER>,
+						       <PIN_PB8__G0_RX0>,
+						       <PIN_PB9__G0_RX1>,
+						       <PIN_PB12__G0_TX0>,
+						       <PIN_PB13__G0_TX1>,
+						       <PIN_PB16__G0_MDC>,
+						       <PIN_PB17__G0_MDIO>;
+					};
+
+					mci0_0_4bit {
+						pins = <PIN_PC4__MCI0_CK>,
+						       <PIN_PC5__MCI0_CDA>,
+						       <PIN_PC6__MCI0_DA0>,
+						       <PIN_PC7__MCI0_DA1>,
+						       <PIN_PC8__MCI0_DA2>,
+						       <PIN_PC9__MCI0_DA3>;
+					};
+
+					mci1_0_4bit {
+						pins = <PIN_PE18__MCI1_CK>,
+						       <PIN_PE19__MCI1_CDA>,
+						       <PIN_PE20__MCI1_DA0>,
+						       <PIN_PE21__MCI1_DA1>,
+						       <PIN_PE22__MCI1_DA2>,
+						       <PIN_PE23__MCI1_DA3>;
+					};
+
+					i2c2_0 {
+						pins = <PIN_PB29__TWD2>,
+						       <PIN_PB30__TWCK2>;
+					};
+				};
+
+				pinctrl_mac0_default: mac0_default {
+					mux {
+						function = "A";
+						groups = "mac0_0_rmii";
+					};
+				};
+
+				pinctrl_i2c2_default: i2c2_default {
+					mux {
+						function = "A";
+						groups = "i2c2_0";
+					};
+				};
+
+				pinctrl_mci0_default: mci0_default {
+					mux {
+						function = "B";
+						groups = "mci0_0_4bit";
+					};
+
+					conf-cmd_data {
+						pins = <PIN_PC5__MCI0_CDA>,
+						       <PIN_PC6__MCI0_DA0>,
+						       <PIN_PC7__MCI0_DA1>,
+						       <PIN_PC8__MCI0_DA2>,
+						       <PIN_PC9__MCI0_DA3>;
+						bias-pull-up;
+					};
+				};
+
+				pinctrl_mci1_default: mci1_default {
+					mux {
+						function = "C";
+						groups = "mci1_0_4bit";
+					};
+
+					conf-cmd_data {
+						pins = <PIN_PE19__MCI1_CDA>,
+						       <PIN_PE20__MCI1_DA0>,
+						       <PIN_PE21__MCI1_DA1>,
+						       <PIN_PE22__MCI1_DA2>,
+						       <PIN_PE23__MCI1_DA3>;
+						bias-pull-up;
+					};
+				};
+
+			};
+
+			mmc0: mmc at f8000000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mci0_default>;
+				status = "okay";
+				slot at 1 {
+					reg = <1>;
+					bus-width = <4>;
+					cd-gpios = <&pioE 5 0>;
+				};
+			};
+
+			macb0: ethernet at f8020000 {
+				phy-mode = "rmii";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mac0_default>;
+				status = "okay";
+			};
+
+			i2c2: i2c at f8024000 {
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c2_default>;
+			};
+
+			mmc1: mmc at fc000000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mci1_default>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioE 6 0>;
+				};
+			};
+
+			watchdog at fc068640 {
+				status = "okay";
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pb_user1 {
+			label = "pb_user1";
+			gpios = <&pioE 13 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x100>;
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		d8 {
+			label = "d8";
+			/* PE28, conflicts with usart4 rts pin */
+			gpios = <&pioE 28 GPIO_ACTIVE_LOW>;
+		};
+
+		d9 {
+			label = "d9";
+			gpios = <&pioE 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		d10 {
+			label = "d10";
+			gpios = <&pioE 8 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/sama5d4_proto-pinfunc.h b/arch/arm/boot/dts/sama5d4_proto-pinfunc.h
new file mode 100644
index 0000000..a960da3
--- /dev/null
+++ b/arch/arm/boot/dts/sama5d4_proto-pinfunc.h
@@ -0,0 +1,463 @@
+#define PINMUX_PIN(no, ioset) \
+( ((no) & 0xffff) | (((ioset) & 0xff) << 16) )
+
+#define PIN_PA0			0
+#define PIN_PA0__LCDDAT0	PINMUX_PIN(PIN_PA0, 0)
+#define PIN_PA0__TMS		PINMUX_PIN(PIN_PA0, 0)
+#define PIN_PA1			1
+#define PIN_PA1__LCDDAT1	PINMUX_PIN(PIN_PA1, 0)
+#define PIN_PA2			2
+#define PIN_PA2__LCDDAT2	PINMUX_PIN(PIN_PA2, 0)
+#define PIN_PA2__G1_TXCK	PINMUX_PIN(PIN_PA2, 0)
+#define PIN_PA3			3
+#define PIN_PA3__LCDDAT3	PINMUX_PIN(PIN_PA3, 0)
+#define PIN_PA3__G1_RXCK	PINMUX_PIN(PIN_PA3, 0)
+#define PIN_PA4			4
+#define PIN_PA4__LCDDAT4	PINMUX_PIN(PIN_PA4, 0)
+#define PIN_PA4__G1_TXEN	PINMUX_PIN(PIN_PA4, 0)
+#define PIN_PA5			5
+#define PIN_PA5__LCDDAT5	PINMUX_PIN(PIN_PA5, 0)
+#define PIN_PA5__G1_TXER	PINMUX_PIN(PIN_PA5, 0)
+#define PIN_PA6			6
+#define PIN_PA6__LCDDAT6	PINMUX_PIN(PIN_PA6, 0)
+#define PIN_PA6__G1_CRS		PINMUX_PIN(PIN_PA6, 0)
+#define PIN_PA7			7
+#define PIN_PA7__LCDDAT7	PINMUX_PIN(PIN_PA7, 0)
+#define PIN_PA8			8
+#define PIN_PA8__LCDDAT8	PINMUX_PIN(PIN_PA8, 0)
+#define PIN_PA8__TCK		PINMUX_PIN(PIN_PA8, 0)
+#define PIN_PA9			9
+#define PIN_PA9__LCDDAT9	PINMUX_PIN(PIN_PA9, 0)
+#define PIN_PA9__G1_COL		PINMUX_PIN(PIN_PA9, 0)
+#define PIN_PA10		10
+#define PIN_PA10__LCDDAT10	PINMUX_PIN(PIN_PA10, 0)
+#define PIN_PA10__G1_RXDV	PINMUX_PIN(PIN_PA10, 0)
+#define PIN_PA11		11
+#define PIN_PA11__LCDDAT11	PINMUX_PIN(PIN_PA11, 0)
+#define PIN_PA11__G1_RXER	PINMUX_PIN(PIN_PA11, 0)
+#define PIN_PA12		12
+#define PIN_PA12__LCDDAT12	PINMUX_PIN(PIN_PA12, 0)
+#define PIN_PA12__G1_RX0	PINMUX_PIN(PIN_PA12, 0)
+#define PIN_PA13		13
+#define PIN_PA13__LCDDAT13	PINMUX_PIN(PIN_PA13, 0)
+#define PIN_PA13__G1_RX1	PINMUX_PIN(PIN_PA13, 0)
+#define PIN_PA14		14
+#define PIN_PA14__LCDDAT14	PINMUX_PIN(PIN_PA14, 0)
+#define PIN_PA14__G1_TX0	PINMUX_PIN(PIN_PA14, 0)
+#define PIN_PA15		15
+#define PIN_PA15__LCDDAT15	PINMUX_PIN(PIN_PA15, 0)
+#define PIN_PA15__G1_TX1	PINMUX_PIN(PIN_PA15, 0)
+#define PIN_PA16		16
+#define PIN_PA16__LCDDAT16	PINMUX_PIN(PIN_PA16, 0)
+#define PIN_PA16__NTRST		PINMUX_PIN(PIN_PA16, 0)
+#define PIN_PA17		17
+#define PIN_PA17__LCDDAT17	PINMUX_PIN(PIN_PA17, 0)
+#define PIN_PA18		18
+#define PIN_PA18__LCDDAT18	PINMUX_PIN(PIN_PA18, 0)
+#define PIN_PA18__G1_RX2	PINMUX_PIN(PIN_PA18, 0)
+#define PIN_PA19		19
+#define PIN_PA19__LCDDAT19	PINMUX_PIN(PIN_PA19, 0)
+#define PIN_PA19__G1_RX3	PINMUX_PIN(PIN_PA19, 0)
+#define PIN_PA20		20
+#define PIN_PA20__LCDDAT20	PINMUX_PIN(PIN_PA20, 0)
+#define PIN_PA20__G1_TX2	PINMUX_PIN(PIN_PA20, 0)
+#define PIN_PA21		21
+#define PIN_PA21__LCDDAT21	PINMUX_PIN(PIN_PA21, 0)
+#define PIN_PA21__G1_TX3	PINMUX_PIN(PIN_PA21, 0)
+#define PIN_PA22		22
+#define PIN_PA22__LCDDAT22	PINMUX_PIN(PIN_PA22, 0)
+#define PIN_PA22__G1_MDC	PINMUX_PIN(PIN_PA22, 0)
+#define PIN_PA23		23
+#define PIN_PA23__LCDDAT23	PINMUX_PIN(PIN_PA23, 0)
+#define PIN_PA23__G1_MDIO	PINMUX_PIN(PIN_PA23, 0)
+#define PIN_PA24		24
+#define PIN_PA24__LCDPWM	PINMUX_PIN(PIN_PA24, 0)
+#define PIN_PA24__PCK0		PINMUX_PIN(PIN_PA24, 0)
+#define PIN_PA25		25
+#define PIN_PA25__LCDDISP	PINMUX_PIN(PIN_PA25, 0)
+#define PIN_PA25__TD0		PINMUX_PIN(PIN_PA25, 0)
+#define PIN_PA26		26
+#define PIN_PA26__LCDVSYNC	PINMUX_PIN(PIN_PA26, 0)
+#define PIN_PA26__PWMH0		PINMUX_PIN(PIN_PA26, 0)
+#define PIN_PA26__SPI1_NPCS1	PINMUX_PIN(PIN_PA26, 0)
+#define PIN_PA27		27
+#define PIN_PA27__LCDHSYNC	PINMUX_PIN(PIN_PA27, 0)
+#define PIN_PA27__PWML0		PINMUX_PIN(PIN_PA27, 0)
+#define PIN_PA27__SPI1_NPCS2	PINMUX_PIN(PIN_PA27, 0)
+#define PIN_PA28		28
+#define PIN_PA28__LCDPCK	PINMUX_PIN(PIN_PA28, 0)
+#define PIN_PA28__PWMH1		PINMUX_PIN(PIN_PA28, 0)
+#define PIN_PA28__SPI1_NPCS3	PINMUX_PIN(PIN_PA28, 0)
+#define PIN_PA29		29
+#define PIN_PA29__LCDDEN	PINMUX_PIN(PIN_PA29, 0)
+#define PIN_PA29__PWML1		PINMUX_PIN(PIN_PA29, 0)
+#define PIN_PA30		30
+#define PIN_PA30__TWD0		PINMUX_PIN(PIN_PA30, 0)
+#define PIN_PA31		31
+#define PIN_PA31__TWCK0		PINMUX_PIN(PIN_PA31, 0)
+#define PIN_PB0			32
+#define PIN_PB0__G0_TXCK	PINMUX_PIN(PIN_PB0, 0)
+#define PIN_PB1			33
+#define PIN_PB1__G0_RXCK	PINMUX_PIN(PIN_PB1, 0)
+#define PIN_PB1__SCK2		PINMUX_PIN(PIN_PB1, 0)
+#define PIN_PB1__ISI_PCK	PINMUX_PIN(PIN_PB1, 0)
+#define PIN_PB2			34
+#define PIN_PB2__G0_TXEN	PINMUX_PIN(PIN_PB2, 0)
+#define PIN_PB3			35
+#define PIN_PB3__G0_TXER	PINMUX_PIN(PIN_PB3, 0)
+#define PIN_PB3__CTS2		PINMUX_PIN(PIN_PB3, 0)
+#define PIN_PB3__ISI_VSYNC	PINMUX_PIN(PIN_PB3, 0)
+#define PIN_PB4			36
+#define PIN_PB4__G0_CRS		PINMUX_PIN(PIN_PB4, 1)
+#define PIN_PB4__RXD2		PINMUX_PIN(PIN_PB4, 1)
+#define PIN_PB4__ISI_HSYNC	PINMUX_PIN(PIN_PB4, 1)
+#define PIN_PB5			37
+#define PIN_PB5__G0_COL		PINMUX_PIN(PIN_PB5, 0)
+#define PIN_PB5__TXD2		PINMUX_PIN(PIN_PB5, 0)
+#define PIN_PB5__PCK2		PINMUX_PIN(PIN_PB5, 0)
+#define PIN_PB6			38
+#define PIN_PB6__G0_RXDV	PINMUX_PIN(PIN_PB6, 0)
+#define PIN_PB7			39
+#define PIN_PB7__G0_RXER	PINMUX_PIN(PIN_PB7, 0)
+#define PIN_PB8			40
+#define PIN_PB8__G0_RX0		PINMUX_PIN(PIN_PB8, 0)
+#define PIN_PB9			41
+#define PIN_PB9__G0_RX1		PINMUX_PIN(PIN_PB9, 0)
+#define PIN_PB10		42
+#define PIN_PB10__G0_RX2	PINMUX_PIN(PIN_PB10, 0)
+#define PIN_PB10__PCK2		PINMUX_PIN(PIN_PB10, 0)
+#define PIN_PB10__PWML1		PINMUX_PIN(PIN_PB10, 0)
+#define PIN_PB11		43
+#define PIN_PB11__G0_RX3	PINMUX_PIN(PIN_PB11, 0)
+#define PIN_PB11__RTS2		PINMUX_PIN(PIN_PB11, 0)
+#define PIN_PB11__PWMH1		PINMUX_PIN(PIN_PB11, 0)
+#define PIN_PB12		44
+#define PIN_PB12__G0_TX0	PINMUX_PIN(PIN_PB12, 0)
+#define PIN_PB13		45
+#define PIN_PB13__G0_TX1	PINMUX_PIN(PIN_PB13, 0)
+#define PIN_PB14		46
+#define PIN_PB14__G0_TX2	PINMUX_PIN(PIN_PB14, 0)
+#define PIN_PB14__SPI2_NPCS1	PINMUX_PIN(PIN_PB14, 0)
+#define PIN_PB14__PWMH0		PINMUX_PIN(PIN_PB14, 0)
+#define PIN_PB15		47
+#define PIN_PB15__G0_TX3	PINMUX_PIN(PIN_PB15, 0)
+#define PIN_PB15__SPI2_NPCS2	PINMUX_PIN(PIN_PB15, 0)
+#define PIN_PB15__PWML0		PINMUX_PIN(PIN_PB15, 0)
+#define PIN_PB16		48
+#define PIN_PB16__G0_MDC	PINMUX_PIN(PIN_PB16, 0)
+#define PIN_PB17		49
+#define PIN_PB17__G0_MDIO	PINMUX_PIN(PIN_PB17, 0)
+#define PIN_PB18		50
+#define PIN_PB18__SPI1_MISO	PINMUX_PIN(PIN_PB18, 0)
+#define PIN_PB18__D8		PINMUX_PIN(PIN_PB18, 0)
+#define PIN_PB19		51
+#define PIN_PB19__SPI1_MISO	PINMUX_PIN(PIN_PB19, 0)
+#define PIN_PB19__D9		PINMUX_PIN(PIN_PB19, 0)
+#define PIN_PB20		52
+#define PIN_PB20__SPI1_SPCK	PINMUX_PIN(PIN_PB20, 0)
+#define PIN_PB20__D10		PINMUX_PIN(PIN_PB20, 0)
+#define PIN_PB21		53
+#define PIN_PB21__SPI1_NPCS0	PINMUX_PIN(PIN_PB21, 0)
+#define PIN_PB21__D11		PINMUX_PIN(PIN_PB21, 0)
+#define PIN_PB22		54
+#define PIN_PB22__SPI1_NPCS1	PINMUX_PIN(PIN_PB22, 0)
+#define PIN_PB22__D12		PINMUX_PIN(PIN_PB22, 0)
+#define PIN_PB23		55
+#define PIN_PB23__SPI1_NPCS2	PINMUX_PIN(PIN_PB23, 0)
+#define PIN_PB23__D13		PINMUX_PIN(PIN_PB23, 0)
+#define PIN_PB24		56
+#define PIN_PB24__DRXD		PINMUX_PIN(PIN_PB24, 0)
+#define PIN_PB24__D14		PINMUX_PIN(PIN_PB24, 0)
+#define PIN_PB24__TDI		PINMUX_PIN(PIN_PB24, 0)
+#define PIN_PB25		57
+#define PIN_PB25__DTXD		PINMUX_PIN(PIN_PB25, 0)
+#define PIN_PB25__D15		PINMUX_PIN(PIN_PB25, 0)
+#define PIN_PB25__TD0		PINMUX_PIN(PIN_PB25, 0)
+#define PIN_PB26		58
+#define PIN_PB26__PCK0		PINMUX_PIN(PIN_PB26, 0)
+#define PIN_PB26__RK0		PINMUX_PIN(PIN_PB26, 0)
+#define PIN_PB26__PWMH0		PINMUX_PIN(PIN_PB26, 0)
+#define PIN_PB27		59
+#define PIN_PB27__SPI1_NPCS3	PINMUX_PIN(PIN_PB27, 0)
+#define PIN_PB27__TK0		PINMUX_PIN(PIN_PB27, 0)
+#define PIN_PB27__PWML0		PINMUX_PIN(PIN_PB27, 0)
+#define PIN_PB28		60
+#define PIN_PB28__SPI2_NPCS3	PINMUX_PIN(PIN_PB28, 0)
+#define PIN_PB28__TD0		PINMUX_PIN(PIN_PB28, 0)
+#define PIN_PB28__PWMH1		PINMUX_PIN(PIN_PB28, 0)
+#define PIN_PB29		61
+#define PIN_PB29__TWD2		PINMUX_PIN(PIN_PB29, 0)
+#define PIN_PB29__RD0		PINMUX_PIN(PIN_PB29, 0)
+#define PIN_PB29__PWML1		PINMUX_PIN(PIN_PB29, 0)
+#define PIN_PB30		62
+#define PIN_PB30__TWCK2		PINMUX_PIN(PIN_PB30, 0)
+#define PIN_PB30__RF0		PINMUX_PIN(PIN_PB30, 0)
+#define PIN_PB31		63
+#define PIN_PB31__TF0		PINMUX_PIN(PIN_PB31, 0)
+#define PIN_PC0			64
+#define PIN_PC0__SPI0_MISO	PINMUX_PIN(PIN_PC0, 0)
+#define PIN_PC0__PWMH2		PINMUX_PIN(PIN_PC0, 0)
+#define PIN_PC0__ISI_D8		PINMUX_PIN(PIN_PC0, 0)
+#define PIN_PC1			65
+#define PIN_PC1__SPI0_MOSI	PINMUX_PIN(PIN_PC1, 0)
+#define PIN_PC1__PWML2		PINMUX_PIN(PIN_PC1, 0)
+#define PIN_PC1__ISI_D9		PINMUX_PIN(PIN_PC1, 0)
+#define PIN_PC2			66
+#define PIN_PC2__SPI0_SPCK	PINMUX_PIN(PIN_PC2, 0)
+#define PIN_PC2__PWMH3		PINMUX_PIN(PIN_PC2, 0)
+#define PIN_PC2__ISI_D10	PINMUX_PIN(PIN_PC2, 0)
+#define PIN_PC3			67
+#define PIN_PC3__SPI0_NPCS0	PINMUX_PIN(PIN_PC3, 0)
+#define PIN_PC3__PWML3		PINMUX_PIN(PIN_PC3, 0)
+#define PIN_PC3__ISI_D11	PINMUX_PIN(PIN_PC3, 0)
+#define PIN_PC4			68
+#define PIN_PC4__SPI0_NPCS1	PINMUX_PIN(PIN_PC4, 0)
+#define PIN_PC4__MCI0_CK	PINMUX_PIN(PIN_PC4, 0)
+#define PIN_PC4__PCK1		PINMUX_PIN(PIN_PC4, 0)
+#define PIN_PC5			69
+#define PIN_PC5__D0		PINMUX_PIN(PIN_PC5, 0)
+#define PIN_PC5__MCI0_CDA	PINMUX_PIN(PIN_PC5, 0)
+#define PIN_PC6			70
+#define PIN_PC6__D1		PINMUX_PIN(PIN_PC6, 0)
+#define PIN_PC6__MCI0_DA0	PINMUX_PIN(PIN_PC6, 0)
+#define PIN_PC7			71
+#define PIN_PC7__D2		PINMUX_PIN(PIN_PC7, 0)
+#define PIN_PC7__MCI0_DA1	PINMUX_PIN(PIN_PC7, 0)
+#define PIN_PC8			72
+#define PIN_PC8__D3		PINMUX_PIN(PIN_PC8, 0)
+#define PIN_PC8__MCI0_DA2	PINMUX_PIN(PIN_PC8, 0)
+#define PIN_PC9			73
+#define PIN_PC9__D4		PINMUX_PIN(PIN_PC9, 0)
+#define PIN_PC9__MCI0_DA3	PINMUX_PIN(PIN_PC9, 0)
+#define PIN_PC10		74
+#define PIN_PC10__D5		PINMUX_PIN(PIN_PC10, 0)
+#define PIN_PC10__MCI0_DA4	PINMUX_PIN(PIN_PC10, 0)
+#define PIN_PC11		75
+#define PIN_PC11__D6		PINMUX_PIN(PIN_PC11, 0)
+#define PIN_PC11__MCI0_DA5	PINMUX_PIN(PIN_PC11, 0)
+#define PIN_PC12		76
+#define PIN_PC12__D7		PINMUX_PIN(PIN_PC12, 0)
+#define PIN_PC12__MCI0_DA6	PINMUX_PIN(PIN_PC12, 0)
+#define PIN_PC13		77
+#define PIN_PC13__NRD_NANDOE	PINMUX_PIN(PIN_PC13, 0)
+#define PIN_PC13__MCI0_DA7	PINMUX_PIN(PIN_PC13, 0)
+#define PIN_PC14		78
+#define PIN_PC14__NWE_NANDWE	PINMUX_PIN(PIN_PC14, 0)
+#define PIN_PC15		79
+#define PIN_PC15__NCS3		PINMUX_PIN(PIN_PC15, 0)
+#define PIN_PC16		80
+#define PIN_PC16__NANDRDY	PINMUX_PIN(PIN_PC16, 0)
+#define PIN_PC17		81
+#define PIN_PC17__A21_NANDALE	PINMUX_PIN(PIN_PC17, 0)
+#define PIN_PC18		82
+#define PIN_PC18__A22_NANDCLE	PINMUX_PIN(PIN_PC18, 0)
+#define PIN_PC19		83
+#define PIN_PC19__ISI_D0	PINMUX_PIN(PIN_PC19, 0)
+#define PIN_PC19__TK1		PINMUX_PIN(PIN_PC19, 0)
+#define PIN_PC20		84
+#define PIN_PC20__ISI_D1	PINMUX_PIN(PIN_PC20, 0)
+#define PIN_PC20__TF1		PINMUX_PIN(PIN_PC20, 0)
+#define PIN_PC21		85
+#define PIN_PC21__ISI_D2	PINMUX_PIN(PIN_PC21, 0)
+#define PIN_PC21__TD1		PINMUX_PIN(PIN_PC21, 0)
+#define PIN_PC22		86
+#define PIN_PC22__ISI_D3	PINMUX_PIN(PIN_PC22, 0)
+#define PIN_PC22__RF1		PINMUX_PIN(PIN_PC22, 0)
+#define PIN_PC23		87
+#define PIN_PC23__ISI_D4	PINMUX_PIN(PIN_PC23, 0)
+#define PIN_PC23__RD1		PINMUX_PIN(PIN_PC23, 0)
+#define PIN_PC24		88
+#define PIN_PC24__ISI_D5	PINMUX_PIN(PIN_PC24, 0)
+#define PIN_PC24__RK1		PINMUX_PIN(PIN_PC24, 0)
+#define PIN_PC24__PCK1		PINMUX_PIN(PIN_PC24, 0)
+#define PIN_PC25		89
+#define PIN_PC25__ISI_D6	PINMUX_PIN(PIN_PC25, 0)
+#define PIN_PC25__TWD3		PINMUX_PIN(PIN_PC25, 0)
+#define PIN_PC25__URXD1		PINMUX_PIN(PIN_PC25, 0)
+#define PIN_PC26		90
+#define PIN_PC26__ISI_D7	PINMUX_PIN(PIN_PC26, 0)
+#define PIN_PC26__TWCK3		PINMUX_PIN(PIN_PC26, 0)
+#define PIN_PC26__UTXD1		PINMUX_PIN(PIN_PC26, 0)
+#define PIN_PC27		91
+#define PIN_PC27__AD0		PINMUX_PIN(PIN_PC27, 0)
+#define PIN_PC27__SPI0_NPCS1	PINMUX_PIN(PIN_PC27, 0)
+#define PIN_PC27__PWML0		PINMUX_PIN(PIN_PC27, 0)
+#define PIN_PC28		92
+#define PIN_PC28__AD1		PINMUX_PIN(PIN_PC28, 0)
+#define PIN_PC28__SPI0_NPCS2	PINMUX_PIN(PIN_PC28, 0)
+#define PIN_PC28__PWML1		PINMUX_PIN(PIN_PC28, 0)
+#define PIN_PC29		93
+#define PIN_PC29__AD2		PINMUX_PIN(PIN_PC29, 0)
+#define PIN_PC29__SPI0_NPCS3	PINMUX_PIN(PIN_PC29, 0)
+#define PIN_PC29__PWMFI0	PINMUX_PIN(PIN_PC29, 0)
+#define PIN_PC30		94
+#define PIN_PC30__AD3		PINMUX_PIN(PIN_PC30, 0)
+#define PIN_PC30__PWMH0		PINMUX_PIN(PIN_PC30, 0)
+#define PIN_PC31		95
+#define PIN_PC31__AD4		PINMUX_PIN(PIN_PC31, 0)
+#define PIN_PC31__PWMH1		PINMUX_PIN(PIN_PC31, 0)
+#define PIN_PD0			96
+#define PIN_PD1			97
+#define PIN_PD2			98
+#define PIN_PD3			99
+#define PIN_PD4			100
+#define PIN_PD5			101
+#define PIN_PD6			102
+#define PIN_PD7			103
+#define PIN_PD8			104
+#define PIN_PD8__PCK0		PINMUX_PIN(PIN_PD8, 0)
+#define PIN_PD9			105
+#define PIN_PD9__FIQ		PINMUX_PIN(PIN_PD9, 0)
+#define PIN_PD10		106
+#define PIN_PD10__CTS0		PINMUX_PIN(PIN_PD10, 0)
+#define PIN_PD11		107
+#define PIN_PD11__RTS0		PINMUX_PIN(PIN_PD11, 0)
+#define PIN_PD11__SPI2_MISO	PINMUX_PIN(PIN_PD11, 0)
+#define PIN_PD12		108
+#define PIN_PD12__RXD0		PINMUX_PIN(PIN_PD12, 0)
+#define PIN_PD13		109
+#define PIN_PD13__TXD0		PINMUX_PIN(PIN_PD13, 0)
+#define PIN_PD13__SPI2_MOSI	PINMUX_PIN(PIN_PD13, 0)
+#define PIN_PD14		110
+#define PIN_PD14__CTS1		PINMUX_PIN(PIN_PD14, 0)
+#define PIN_PD15		111
+#define PIN_PD15__RTS1		PINMUX_PIN(PIN_PD15, 0)
+#define PIN_PD15__SPI2_SPCK	PINMUX_PIN(PIN_PD15, 0)
+#define PIN_PD16		112
+#define PIN_PD16__RXD1		PINMUX_PIN(PIN_PD16, 0)
+#define PIN_PD17		113
+#define PIN_PD17__TXD1		PINMUX_PIN(PIN_PD17, 0)
+#define PIN_PD17__SPI2_NPCS0	PINMUX_PIN(PIN_PD17, 0)
+#define PIN_PD18		114
+#define PIN_PD19		115
+#define PIN_PD20		116
+#define PIN_PD21		117
+#define PIN_PD22		118
+#define PIN_PD23		119
+#define PIN_PD24		120
+#define PIN_PD25		121
+#define PIN_PD26		122
+#define PIN_PD27		123
+#define PIN_PD28		124
+#define PIN_PD28__SCK0		PINMUX_PIN(PIN_PD28, 0)
+#define PIN_PD29		125
+#define PIN_PD29__SCK1		PINMUX_PIN(PIN_PD29, 0)
+#define PIN_PD30		126
+#define PIN_PD31		127
+#define PIN_PD31__SPI0_NPCS2	PINMUX_PIN(PIN_PD31, 0)
+#define PIN_PD31__PCK1		PINMUX_PIN(PIN_PD31, 0)
+#define PIN_PE0			128
+#define PIN_PE0__A0_NBS0	PINMUX_PIN(PIN_PE0, 0)
+#define PIN_PE0__MCI0_CDB	PINMUX_PIN(PIN_PE0, 0)
+#define PIN_PE0__CTS4		PINMUX_PIN(PIN_PE0, 0)
+#define PIN_PE1			129
+#define PIN_PE1__A1		PINMUX_PIN(PIN_PE1, 0)
+#define PIN_PE1__MCI0_DB0	PINMUX_PIN(PIN_PE1, 0)
+#define PIN_PE2			130
+#define PIN_PE2__A2		PINMUX_PIN(PIN_PE2, 0)
+#define PIN_PE2__MCI0_DB1	PINMUX_PIN(PIN_PE2, 0)
+#define PIN_PE3			131
+#define PIN_PE3__A3		PINMUX_PIN(PIN_PE3, 0)
+#define PIN_PE3__MCI0_DB2	PINMUX_PIN(PIN_PE3, 0)
+#define PIN_PE4			132
+#define PIN_PE4__A4		PINMUX_PIN(PIN_PE4, 0)
+#define PIN_PE4__MCI0_DB3	PINMUX_PIN(PIN_PE4, 0)
+#define PIN_PE5			133
+#define PIN_PE5__A5		PINMUX_PIN(PIN_PE5, 0)
+#define PIN_PE5__CTS3		PINMUX_PIN(PIN_PE5, 0)
+#define PIN_PE6			134
+#define PIN_PE6__A6		PINMUX_PIN(PIN_PE6, 0)
+#define PIN_PE6__TIOA3		PINMUX_PIN(PIN_PE6, 0)
+#define PIN_PE7			135
+#define PIN_PE7__A7		PINMUX_PIN(PIN_PE7, 0)
+#define PIN_PE7__TIOB3		PINMUX_PIN(PIN_PE7, 0)
+#define PIN_PE7__PWMFI1		PINMUX_PIN(PIN_PE7, 0)
+#define PIN_PE8			136
+#define PIN_PE8__A8		PINMUX_PIN(PIN_PE8, 0)
+#define PIN_PE8__TCLK3		PINMUX_PIN(PIN_PE8, 0)
+#define PIN_PE8__PWML3		PINMUX_PIN(PIN_PE8, 0)
+#define PIN_PE9			137
+#define PIN_PE9__A9		PINMUX_PIN(PIN_PE9, 0)
+#define PIN_PE9__TIOA2		PINMUX_PIN(PIN_PE9, 0)
+#define PIN_PE10		138
+#define PIN_PE10__A10		PINMUX_PIN(PIN_PE10, 0)
+#define PIN_PE10__TIOB2		PINMUX_PIN(PIN_PE10, 0)
+#define PIN_PE11		139
+#define PIN_PE11__A11		PINMUX_PIN(PIN_PE11, 0)
+#define PIN_PE11__TCLK2		PINMUX_PIN(PIN_PE11, 0)
+#define PIN_PE12		140
+#define PIN_PE12__A12		PINMUX_PIN(PIN_PE12, 0)
+#define PIN_PE12__TIOA1		PINMUX_PIN(PIN_PE12, 0)
+#define PIN_PE12__PWMH2		PINMUX_PIN(PIN_PE12, 0)
+#define PIN_PE13		141
+#define PIN_PE13__A13		PINMUX_PIN(PIN_PE13, 0)
+#define PIN_PE13__TIOB1		PINMUX_PIN(PIN_PE13, 0)
+#define PIN_PE13__PWML2		PINMUX_PIN(PIN_PE13, 0)
+#define PIN_PE14		142
+#define PIN_PE14__A14		PINMUX_PIN(PIN_PE14, 0)
+#define PIN_PE14__TCLK1		PINMUX_PIN(PIN_PE14, 0)
+#define PIN_PE14__PWMH3		PINMUX_PIN(PIN_PE14, 0)
+#define PIN_PE15		143
+#define PIN_PE15__A15		PINMUX_PIN(PIN_PE15, 0)
+#define PIN_PE15__SCK3		PINMUX_PIN(PIN_PE15, 0)
+#define PIN_PE15__TIOA0		PINMUX_PIN(PIN_PE15, 0)
+#define PIN_PE16		144
+#define PIN_PE16__A16		PINMUX_PIN(PIN_PE16, 0)
+#define PIN_PE16__RXD3		PINMUX_PIN(PIN_PE16, 0)
+#define PIN_PE16__TIOB0		PINMUX_PIN(PIN_PE16, 0)
+#define PIN_PE17		145
+#define PIN_PE17__A17		PINMUX_PIN(PIN_PE17, 0)
+#define PIN_PE17__TXD3		PINMUX_PIN(PIN_PE17, 0)
+#define PIN_PE17__TCLK0		PINMUX_PIN(PIN_PE17, 0)
+#define PIN_PE18		146
+#define PIN_PE18__A18		PINMUX_PIN(PIN_PE18, 0)
+#define PIN_PE18__TIOA5		PINMUX_PIN(PIN_PE18, 0)
+#define PIN_PE18__MCI1_CK	PINMUX_PIN(PIN_PE18, 0)
+#define PIN_PE19		147
+#define PIN_PE19__A19		PINMUX_PIN(PIN_PE19, 0)
+#define PIN_PE19__TIOB5		PINMUX_PIN(PIN_PE19, 0)
+#define PIN_PE19__MCI1_CDA	PINMUX_PIN(PIN_PE19, 0)
+#define PIN_PE20		148
+#define PIN_PE20__A20		PINMUX_PIN(PIN_PE20, 0)
+#define PIN_PE20__TCLK5		PINMUX_PIN(PIN_PE20, 0)
+#define PIN_PE20__MCI1_DA0	PINMUX_PIN(PIN_PE20, 0)
+#define PIN_PE21		149
+#define PIN_PE21__A23		PINMUX_PIN(PIN_PE21, 0)
+#define PIN_PE21__TIOA4		PINMUX_PIN(PIN_PE21, 0)
+#define PIN_PE21__MCI1_DA1	PINMUX_PIN(PIN_PE21, 0)
+#define PIN_PE22		150
+#define PIN_PE22__A24		PINMUX_PIN(PIN_PE22, 0)
+#define PIN_PE22__TIOB4		PINMUX_PIN(PIN_PE22, 0)
+#define PIN_PE22__MCI1_DA2	PINMUX_PIN(PIN_PE22, 0)
+#define PIN_PE23		151
+#define PIN_PE23__A25		PINMUX_PIN(PIN_PE23, 0)
+#define PIN_PE23__TCLK4		PINMUX_PIN(PIN_PE23, 0)
+#define PIN_PE23__MCI1_DA3	PINMUX_PIN(PIN_PE23, 0)
+#define PIN_PE24		152
+#define PIN_PE24__NCS0		PINMUX_PIN(PIN_PE24, 0)
+#define PIN_PE24__RTS3		PINMUX_PIN(PIN_PE24, 0)
+#define PIN_PE25		153
+#define PIN_PE25__NCS1		PINMUX_PIN(PIN_PE25, 0)
+#define PIN_PE25__SCK4		PINMUX_PIN(PIN_PE25, 0)
+#define PIN_PE25__IRQ		PINMUX_PIN(PIN_PE25, 0)
+#define PIN_PE26		154
+#define PIN_PE26__NCS2		PINMUX_PIN(PIN_PE26, 0)
+#define PIN_PE26__RXD4		PINMUX_PIN(PIN_PE26, 0)
+#define PIN_PE26__A18		PINMUX_PIN(PIN_PE26, 0)
+#define PIN_PE27		155
+#define PIN_PE27__NWR1_NBS1	PINMUX_PIN(PIN_PE27, 0)
+#define PIN_PE27__TXD4		PINMUX_PIN(PIN_PE27, 0)
+#define PIN_PE28		156
+#define PIN_PE28__NWAIT		PINMUX_PIN(PIN_PE28, 0)
+#define PIN_PE28__RTS4		PINMUX_PIN(PIN_PE28, 0)
+#define PIN_PE28__A19		PINMUX_PIN(PIN_PE28, 0)
+#define PIN_PE29		157
+#define PIN_PE29__DIBP		PINMUX_PIN(PIN_PE29, 0)
+#define PIN_PE29__URXD0		PINMUX_PIN(PIN_PE29, 0)
+#define PIN_PE29__TWD1		PINMUX_PIN(PIN_PE29, 0)
+#define PIN_PE30		158
+#define PIN_PE30__DIBN		PINMUX_PIN(PIN_PE30, 0)
+#define PIN_PE30__UTXD0		PINMUX_PIN(PIN_PE30, 0)
+#define PIN_PE30__TWCK1		PINMUX_PIN(PIN_PE30, 0)
+#define PIN_PE31		159
+#define PIN_PE31__ADTRG		PINMUX_PIN(PIN_PE31, 0)
diff --git a/arch/arm/boot/dts/sama5d4_proto.dtsi b/arch/arm/boot/dts/sama5d4_proto.dtsi
new file mode 100644
index 0000000..dd66bf6
--- /dev/null
+++ b/arch/arm/boot/dts/sama5d4_proto.dtsi
@@ -0,0 +1,716 @@
+/*
+ * sama5d4.dtsi - Device Tree Include file for SAMA5D4 family SoC
+ *
+ *  Copyright (C) 2014 Atmel,
+ *                2014 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/dma/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "sama5d4_proto-pinfunc.h"
+
+/ {
+	model = "Atmel SAMA5D4 family SoC";
+	compatible = "atmel,sama5d4";
+	interrupt-parent = <&aic>;
+
+	aliases {
+		serial0 = &usart3;
+		gpio0 = &pioA;
+		gpio1 = &pioB;
+		gpio2 = &pioC;
+		gpio3 = &pioD;
+		gpio4 = &pioE;
+		tcb0 = &tcb0;
+		tcb1 = &tcb1;
+		i2c2 = &i2c2;
+	};
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		reg = <0x20000000 0x20000000>;
+	};
+
+	clocks {
+		slow_xtal: slow_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		main_xtal: main_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		adc_op_clk: adc_op_clk{
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1000000>;
+		};
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		L2: cache-controller at 00a00000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x00a00000 0x1000>;
+			interrupts = <67 IRQ_TYPE_LEVEL_HIGH 4>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dma1: dma-controller at f0004000 {
+				compatible = "atmel,sama5d4-dma";
+				reg = <0xf0004000 0x200>;
+				interrupts = <50 IRQ_TYPE_LEVEL_HIGH 0>;
+				#dma-cells = <1>;
+				clocks = <&dma1_clk>;
+				clock-names = "dma_clk";
+			};
+
+			ramc0: ramc at f0010000 {
+				compatible = "atmel,sama5d3-ddramc";
+				reg = <0xf0010000 0x200>;
+				clocks = <&ddrck>, <&mpddr_clk>;
+				clock-names = "ddrck", "mpddr";
+			};
+
+			dma0: dma-controller at f0014000 {
+				compatible = "atmel,sama5d4-dma";
+				reg = <0xf0014000 0x200>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 0>;
+				#dma-cells = <1>;
+				clocks = <&dma0_clk>;
+				clock-names = "dma_clk";
+			};
+
+			pmc: pmc at f0018000 {
+				compatible = "atmel,sama5d3-pmc";
+				reg = <0xf0018000 0x120>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupt-controller;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+
+				main_rc_osc: main_rc_osc {
+					compatible = "atmel,at91sam9x5-clk-main-rc-osc";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCRCS>;
+					clock-frequency = <12000000>;
+					clock-accuracy = <100000000>;
+				};
+
+				main_osc: main_osc {
+					compatible = "atmel,at91rm9200-clk-main-osc";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCS>;
+					clocks = <&main_xtal>;
+				};
+
+				main: mainck {
+					compatible = "atmel,at91sam9x5-clk-main";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCSELS>;
+					clocks = <&main_rc_osc &main_osc>;
+				};
+
+				plla: pllack {
+					compatible = "atmel,sama5d3-clk-pll";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_LOCKA>;
+					clocks = <&main>;
+					reg = <0>;
+					atmel,clk-input-range = <12000000 12000000>;
+					#atmel,pll-clk-output-range-cells = <4>;
+					atmel,pll-clk-output-ranges = <600000000 1200000000 0 0>;
+				};
+
+				plladiv: plladivck {
+					compatible = "atmel,at91sam9x5-clk-plldiv";
+					#clock-cells = <0>;
+					clocks = <&plla>;
+				};
+
+				utmi: utmick {
+					compatible = "atmel,at91sam9x5-clk-utmi";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_LOCKU>;
+					clocks = <&main>;
+				};
+
+				mck: masterck {
+					compatible = "atmel,at91sam9x5-clk-master";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MCKRDY>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>;
+					atmel,clk-output-range = <125000000 177000000>;
+					atmel,clk-divisors = <1 2 4 3>;
+				};
+
+				h32ck: h32mxck {
+					#clock-cells = <0>;
+					compatible = "atmel,sama5d4-clk-h32mx";
+					clocks = <&mck>;
+				};
+
+				prog: progck {
+					compatible = "atmel,at91sam9x5-clk-programmable";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					interrupt-parent = <&pmc>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+
+					prog0: prog0 {
+						#clock-cells = <0>;
+						reg = <0>;
+						interrupts = <AT91_PMC_PCKRDY(0)>;
+					};
+
+					prog1: prog1 {
+						#clock-cells = <0>;
+						reg = <1>;
+						interrupts = <AT91_PMC_PCKRDY(1)>;
+					};
+
+					prog2: prog2 {
+						#clock-cells = <0>;
+						reg = <2>;
+						interrupts = <AT91_PMC_PCKRDY(2)>;
+					};
+				};
+
+				smd: smdclk {
+					compatible = "atmel,at91sam9x5-clk-smd";
+					#clock-cells = <0>;
+					clocks = <&plladiv>, <&utmi>;
+				};
+
+				systemck {
+					compatible = "atmel,at91rm9200-clk-system";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					ddrck: ddrck {
+						#clock-cells = <0>;
+						reg = <2>;
+						clocks = <&mck>;
+					};
+
+					lcdck: lcdck {
+						#clock-cells = <0>;
+						reg = <4>;
+						clocks = <&smd>;
+					};
+
+					smdck: smdck {
+						#clock-cells = <0>;
+						reg = <4>;
+						clocks = <&smd>;
+					};
+
+					pck0: pck0 {
+						#clock-cells = <0>;
+						reg = <8>;
+						clocks = <&prog0>;
+					};
+
+					pck1: pck1 {
+						#clock-cells = <0>;
+						reg = <9>;
+						clocks = <&prog1>;
+					};
+
+					pck2: pck2 {
+						#clock-cells = <0>;
+						reg = <10>;
+						clocks = <&prog2>;
+					};
+				};
+
+				periph32ck {
+					compatible = "atmel,at91sam9x5-clk-peripheral";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&h32ck>;
+
+					pioD_clk: pioD_clk {
+						#clock-cells = <0>;
+						reg = <5>;
+					};
+
+					usart0_clk: usart0_clk {
+						#clock-cells = <0>;
+						reg = <6>;
+					};
+
+					usart1_clk: usart1_clk {
+						#clock-cells = <0>;
+						reg = <7>;
+					};
+
+					icm_clk: icm_clk {
+						#clock-cells = <0>;
+						reg = <9>;
+					};
+
+					aes_clk: aes_clk {
+						#clock-cells = <0>;
+						reg = <12>;
+					};
+
+					tdes_clk: tdes_clk {
+						#clock-cells = <0>;
+						reg = <14>;
+					};
+
+					sha_clk: sha_clk {
+						#clock-cells = <0>;
+						reg = <15>;
+					};
+
+					matrix1_clk: matrix1_clk {
+						#clock-cells = <0>;
+						reg = <17>;
+					};
+
+					hsmc_clk: hsmc_clk {
+						#clock-cells = <0>;
+						reg = <22>;
+					};
+
+					pioA_clk: pioA_clk {
+						#clock-cells = <0>;
+						reg = <23>;
+					};
+
+					pioB_clk: pioB_clk {
+						#clock-cells = <0>;
+						reg = <24>;
+					};
+
+					pioC_clk: pioC_clk {
+						#clock-cells = <0>;
+						reg = <25>;
+					};
+
+					pioE_clk: pioE_clk {
+						#clock-cells = <0>;
+						reg = <26>;
+					};
+
+					usart3_clk: usart3_clk {
+						#clock-cells = <0>;
+						reg = <30>;
+					};
+
+					twi2_clk: twi2_clk {
+						#clock-cells = <0>;
+						reg = <34>;
+					};
+
+					mci0_clk: mci0_clk {
+						#clock-cells = <0>;
+						reg = <35>;
+					};
+
+					mci1_clk: mci1_clk {
+						#clock-cells = <0>;
+						reg = <36>;
+					};
+
+					tcb0_clk: tcb0_clk {
+						#clock-cells = <0>;
+						reg = <40>;
+					};
+
+					tcb1_clk: tcb1_clk {
+						#clock-cells = <0>;
+						reg = <41>;
+					};
+
+					tcb2_clk: tcb2_clk {
+						#clock-cells = <0>;
+						reg = <42>;
+					};
+
+					dbgu_clk: dbgu_clk {
+						#clock-cells = <0>;
+						reg = <45>;
+					};
+
+					uhphs_clk: uhphs_clk {
+						#clock-cells = <0>;
+						reg = <46>;
+					};
+
+					udphs_clk: udphs_clk {
+						#clock-cells = <0>;
+						reg = <47>;
+					};
+
+					trng_clk: trng_clk {
+						#clock-cells = <0>;
+						reg = <53>;
+					};
+
+					macb0_clk: macb0_clk {
+						#clock-cells = <0>;
+						reg = <54>;
+					};
+
+					fuse_clk: fuse_clk {
+						#clock-cells = <0>;
+						reg = <57>;
+					};
+
+					securam_clk: securam_clk {
+						#clock-cells = <0>;
+						reg = <59>;
+					};
+
+					smd_clk: smd_clk {
+						#clock-cells = <0>;
+						reg = <61>;
+					};
+
+					catb_clk: catb_clk {
+						#clock-cells = <0>;
+						reg = <63>;
+					};
+				};
+
+				periph64ck {
+					compatible = "atmel,at91sam9x5-clk-peripheral";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&mck>;
+
+					dma0_clk: dma0_clk {
+						#clock-cells = <0>;
+						reg = <8>;
+					};
+
+					cpkcc_clk: cpkcc_clk {
+						#clock-cells = <0>;
+						reg = <10>;
+					};
+
+					mpddr_clk: mpddr_clk {
+						#clock-cells = <0>;
+						reg = <16>;
+					};
+
+					matrix0_clk: matrix0_clk {
+						#clock-cells = <0>;
+						reg = <18>;
+					};
+
+					vdec_clk: vdec_clk {
+						#clock-cells = <0>;
+						reg = <19>;
+					};
+
+					dma1_clk: dma1_clk {
+						#clock-cells = <0>;
+						reg = <50>;
+					};
+				};
+			};
+
+			mmc0: mmc at f8000000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf8000000 0x600>;
+				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(0))>;
+				dma-names = "rxtx";
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&mci0_clk>;
+				clock-names = "mci_clk";
+			};
+
+			tcb0: timer at f801c000 {
+				compatible = "atmel,at91sam9x5-tcb";
+				reg = <0xf801c000 0x100>;
+				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&tcb0_clk>;
+				clock-names = "t0_clk";
+			};
+
+			macb0: ethernet at f8020000 {
+				compatible = "atmel,sama5d4-gem";
+				reg = <0xf8020000 0x100>;
+				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb0_rmii>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&macb0_clk>, <&macb0_clk>;
+				clock-names = "hclk", "pclk";
+				status = "disabled";
+			};
+
+			i2c2: i2c at f8024000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8024000 0x4000>;
+				interrupts = <34 IRQ_TYPE_LEVEL_HIGH 6>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(6))>,
+				       <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(7))>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&twi2_clk>;
+				status = "disabled";
+			};
+
+			mmc1: mmc at fc000000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfc000000 0x600>;
+				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(1))>;
+				dma-names = "rxtx";
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&mci1_clk>;
+				clock-names = "mci_clk";
+			};
+
+			usart3: serial at fc00c000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfc00c000 0x100>;
+				interrupts = <30 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(18))>,
+				       <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(19))>;
+				dma-names = "tx", "rx";
+				clocks = <&usart3_clk>;
+				clock-names = "usart";
+			};
+
+			tcb1: timer at fc020000 {
+				compatible = "atmel,at91sam9x5-tcb";
+				reg = <0xfc020000 0x100>;
+				interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&tcb1_clk>;
+				clock-names = "t0_clk";
+			};
+
+			rstc at fc068600 {
+				compatible = "atmel,at91sam9g45-rstc";
+				reg = <0xfc068600 0x10>;
+			};
+
+			shdwc at fc068610 {
+				compatible = "atmel,at91sam9x5-shdwc";
+				reg = <0xfc068610 0x10>;
+			};
+
+			pit: timer at fc068630 {
+				compatible = "atmel,at91sam9260-pit";
+				reg = <0xfc068630 0x10>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
+				clocks = <&h32ck>;
+			};
+
+			watchdog at fc068640 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfc068640 0x10>;
+				status = "disabled";
+			};
+
+			sckc at fc068650 {
+				compatible = "atmel,at91sam9x5-sckc";
+				reg = <0xfc068650 0x4>;
+
+				slow_rc_osc: slow_rc_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
+					#clock-cells = <0>;
+					clock-frequency = <32768>;
+					clock-accuracy = <250000000>;
+					atmel,startup-time-usec = <75>;
+				};
+
+				slow_osc: slow_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-osc";
+					#clock-cells = <0>;
+					clocks = <&slow_xtal>;
+					atmel,startup-time-usec = <1200000>;
+				};
+
+				clk32k: slowck {
+					compatible = "atmel,at91sam9x5-clk-slow";
+					#clock-cells = <0>;
+					clocks = <&slow_rc_osc &slow_osc>;
+				};
+			};
+
+			rtc at fc0686b0 {
+				compatible = "atmel,at91rm9200-rtc";
+				reg = <0xfc0686b0 0x30>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+			};
+
+			dbgu: serial at fc069000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfc069000 0x200>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&dbgu_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
+			pio_reg: syscon at fc06a000 {
+				compatible = "atmel,sama5d4-pio_reg", "syscon";
+				reg = <0xfc06a000 0x5000>;
+			};
+
+			pinctrl at fc06a000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,sama5d4-pinctrl", "simple-bus";
+				atmel,pio_reg = <&pio_reg 0x0>;
+			};
+
+			pioA: gpio at fc06a000 {
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				clocks = <&pioA_clk>;
+			};
+			
+			pioB: gpio at fc06b000 {
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				clocks = <&pioB_clk>;
+			};
+			
+			pioC: gpio at fc06c000 {
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				clocks = <&pioC_clk>;
+			};
+			
+			pioD: gpio at fc06d000 {
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				clocks = <&pioD_clk>;
+			};
+			
+			pioE: gpio at fc06e000 {
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 1>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				clocks = <&pioE_clk>;
+			};
+			
+			aic: interrupt-controller at fc06e000 {
+				#interrupt-cells = <3>;
+				compatible = "atmel,sama5d4-aic";
+				interrupt-controller;
+				reg = <0xfc06e000 0x200>;
+				atmel,external-irqs = <56>;
+			};
+		};
+	};
+};
-- 
2.2.0
