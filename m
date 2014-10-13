From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 13 Oct 2014 17:36:00 +0800
Subject: [PATCHv5 3/6] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1413192963-11153-4-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen Lu <B46807@freescale.com>
Signed-off-by: Chao Fu <B44548@freescale.com>
Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/ls1021a-twr.dts | 127 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100755 arch/arm/boot/dts/ls1021a-twr.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f89e5da..dfc7deb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -252,6 +252,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6sl-evk.dtb \
 	imx6sx-sdb.dtb \
 	ls1021a-qds.dtb \
+	ls1021a-twr.dtb \
 	vf610-colibri-eval-v3.dtb \
 	vf610-cosmic.dtb \
 	vf610-twr.dtb
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
new file mode 100755
index 0000000..1e463fe
--- /dev/null
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -0,0 +1,127 @@
+/*
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+#include "ls1021a.dtsi"
+
+/ {
+	model = "LS1021A TWR Board";
+
+	aliases {
+		enet2_rgmii_phy = &rgmii_phy1;
+		enet0_sgmii_phy = &sgmii_phy2;
+		enet1_sgmii_phy = &sgmii_phy0;
+	};
+};
+
+&dspi1 {
+	bus-num = <0>;
+	status = "okay";
+
+	dspiflash: s25fl064k at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl064k";
+		spi-max-frequency = <16000000>;
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	/* NOR, and CPLD on board */
+	ranges = <0x0 0x0 0x0 0x60000000 0x08000000>;
+	status = "okay";
+
+	nor at 0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x8000000>;
+		bank-width = <2>;
+		device-width = <1>;
+	};
+};
+
+&lpuart0 {
+	status = "okay";
+};
+
+&mdio0 {
+	sgmii_phy0: ethernet-phy at 0 {
+		reg = <0x0>;
+	};
+	rgmii_phy1: ethernet-phy at 1 {
+		reg = <0x1>;
+	};
+	sgmii_phy2: ethernet-phy at 2 {
+		reg = <0x2>;
+	};
+	tbi1: tbi-phy at 1f {
+		reg = <0x1f>;
+		device_type = "tbi-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
1.8.0
