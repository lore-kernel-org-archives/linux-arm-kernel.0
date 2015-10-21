From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 21 Oct 2015 20:36:30 +0900
Subject: [PATCH 4/4] ARM: dts: uniphier: add ProXstream2 Vodka board support
In-Reply-To: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1445427390-22750-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial version of DTS for ProXstream2 Vodka board.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/Makefile                       |  3 +-
 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts | 74 ++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d7eefec..2e1bc82 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -673,7 +673,8 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ph1-pro4-ref.dtb \
 	uniphier-ph1-sld3-ref.dtb \
 	uniphier-ph1-sld8-ref.dtb \
-	uniphier-proxstream2-gentil.dtb
+	uniphier-proxstream2-gentil.dtb \
+	uniphier-proxstream2-vodka.dtb
 dtb-$(CONFIG_ARCH_VERSATILE) += \
 	versatile-ab.dtb \
 	versatile-pb.dtb
diff --git a/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts b/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
new file mode 100644
index 0000000..76040bb
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
@@ -0,0 +1,74 @@
+/*
+ * Device Tree Source for UniPhier ProXstream2 Vodka Board
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
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
+/include/ "uniphier-proxstream2.dtsi"
+
+/ {
+	model = "UniPhier ProXstream2 Vodka Board";
+	compatible = "socionext,proxstream2-vodka", "socionext,proxstream2";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+	};
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
-- 
1.9.1
