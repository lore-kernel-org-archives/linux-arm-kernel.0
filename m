From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:18:34 +0900
Subject: [PATCH 7/9] ARM: dts: uniphier: add PH1-Pro4 Ace board support
In-Reply-To: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456471116-8140-8-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial commit for PH1-Pro4 Ace board support.

Note:
There are two variants for the amount of DDR memory; 1GB or 2GB.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts | 113 ++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a4a6d70..d9d899f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -736,6 +736,7 @@ dtb-$(CONFIG_ARCH_U8500) += \
 dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ph1-ld4-ref.dtb \
 	uniphier-ph1-ld6b-ref.dtb \
+	uniphier-ph1-pro4-ace.dtb \
 	uniphier-ph1-pro4-ref.dtb \
 	uniphier-ph1-sld3-ref.dtb \
 	uniphier-ph1-sld8-ref.dtb \
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts
new file mode 100644
index 0000000..d343586
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ace.dts
@@ -0,0 +1,113 @@
+/*
+ * Device Tree Source for UniPhier PH1-Pro4 Ace Board
+ *
+ * Copyright (C) 2016 Masahiro Yamada <yamada.masahiro@socionext.com>
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
+/dts-v1/;
+/include/ "uniphier-ph1-pro4.dtsi"
+
+/ {
+	model = "UniPhier PH1-Pro4 Ace Board";
+	compatible = "socionext,ph1-pro4-ace", "socionext,ph1-pro4";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 54 {
+		compatible = "st,24c64";
+		reg = <0x54>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
-- 
1.9.1
