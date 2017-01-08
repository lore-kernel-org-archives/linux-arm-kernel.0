From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  8 Jan 2017 14:30:59 +0100
Subject: [PATCH 3/4] ARM: dts: mt7623: Add Geek Force config
In-Reply-To: <20170108133100.10428-1-afaerber@suse.de>
References: <20170108133100.10428-1-afaerber@suse.de>
Message-ID: <20170108133100.10428-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/mt7623-geekforce.dts | 77 ++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623-geekforce.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fa68843..fc1d4be 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -987,6 +987,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
 	mt7623-evb.dtb \
+	mt7623-geekforce.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
diff --git a/arch/arm/boot/dts/mt7623-geekforce.dts b/arch/arm/boot/dts/mt7623-geekforce.dts
new file mode 100644
index 0000000..ab4cecd
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623-geekforce.dts
@@ -0,0 +1,77 @@
+/*
+ * Copyright (c) 2016-2017 Andreas F?rber
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
+
+#include "mt7623.dtsi"
+
+/ {
+	model = "AsiaRF Geek Force";
+	compatible = "asiarf,geekforce", "mediatek,mt7623";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory {
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+};
+
+/* on Raspberry Pi connector */
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.10.2
