From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 25 May 2017 11:19:15 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add support for LD20 Global board
In-Reply-To: <1495678755-13218-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1495678755-13218-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1495678755-13218-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree support for LD20 Global board.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/Makefile             |  1 +
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 87 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts

diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
index 8d07ee33e66f..4a13a3a97101 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -1,6 +1,7 @@
 dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ld11-global.dtb \
 	uniphier-ld11-ref.dtb \
+	uniphier-ld20-global.dtb \
 	uniphier-ld20-ref.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
new file mode 100644
index 000000000000..e28ff6699048
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -0,0 +1,87 @@
+/*
+ * Device Tree Source for UniPhier LD20 Global Board
+ *
+ * Copyright (C) 2015-2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
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
+/include/ "uniphier-ld20.dtsi"
+
+/ {
+	model = "UniPhier LD20 Global Board (REF_LD20_GP)";
+	compatible = "socionext,uniphier-ld20-global", "socionext,uniphier-ld20";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0xc0000000>;
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
+&i2c0 {
+	status = "okay";
+};
-- 
2.7.4
