From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Fri, 8 Jul 2016 18:15:44 +0800
Subject: [PATCH 5/5] arm64: dts: add LS1046A-QDS board support
In-Reply-To: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
References: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1467972944-12293-6-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

The LS1046A QorIQ development system (QDS) board is a high-performance
computing, evaluation, development, and test platform supporting the
LS1046A SoC.

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 209 ++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9c81b9e..6602718 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
new file mode 100644
index 0000000..5234f6e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -0,0 +1,209 @@
+/*
+ * Device Tree Include file for Freescale Layerscape-1046A family SoC.
+ *
+ * Copyright 2016, Freescale Semiconductor, Inc.
+ *
+ * Shaohui Xie <Shaohui.Xie@nxp.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
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
+/dts-v1/;
+/include/ "fsl-ls1046a.dtsi"
+
+/ {
+	model = "LS1046A QDS Board";
+	compatible = "fsl,ls1046a-qds", "fsl,ls1046a";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		serial0 = &lpuart0;
+		serial1 = &lpuart1;
+		serial2 = &lpuart2;
+		serial3 = &lpuart3;
+		serial4 = &lpuart4;
+		serial5 = &lpuart5;
+	};
+};
+
+&dspi {
+	bus-num = <0>;
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a11", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst25wf040b", "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash at 2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "en25s64", "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <2>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	pca9547 at 77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			ina220 at 40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			ina220 at 41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			rtc at 51 {
+				compatible = "nxp,pcf2129";
+				reg = <0x51>;
+				/* IRQ10_B */
+				interrupts = <0 150 0x4>;
+			};
+
+			eeprom at 56 {
+				compatible = "atmel,24c512";
+				reg = <0x56>;
+			};
+
+			eeprom at 57 {
+				compatible = "atmel,24c512";
+				reg = <0x57>;
+			};
+
+			temp-sensor at 4c {
+				compatible = "adi,adt7461a";
+				reg = <0x4c>;
+			};
+		};
+	};
+};
+
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	/* NOR, NAND Flashes and FPGA on board */
+	ranges = <0x0 0x0 0x0 0x60000000 0x08000000
+		  0x1 0x0 0x0 0x7e800000 0x00010000
+		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
+	status = "okay";
+
+	nor at 0,0 {
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x8000000>;
+		bank-width = <2>;
+		device-width = <1>;
+	};
+
+	nand at 1,0 {
+		compatible = "fsl,ifc-nand";
+		reg = <0x1 0x0 0x10000>;
+	};
+
+	fpga: board-control at 2,0 {
+		compatible = "fsl,ls1046aqds-fpga", "fsl,fpga-qixis";
+		reg = <0x2 0x0 0x0000100>;
+	};
+};
+
+&lpuart0 {
+	status = "okay";
+};
+
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "okay";
+
+	qflash0: s25fl128s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
-- 
2.1.0.27.g96db324
