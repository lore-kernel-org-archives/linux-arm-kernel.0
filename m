From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  4 Oct 2016 17:37:09 +0200
Subject: [RESEND PATCH v2 -next 2/3] ARM64: dts: amlogic: Add basic support
 for Amlogic S905X
In-Reply-To: <1475595430-30075-1-git-send-email-narmstrong@baylibre.com>
References: <1475595430-30075-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1475595430-30075-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patch introduces the basic support for the Amlogic S905X (Meson
GXL) and for the Amlogic evaluation board P212.
No documentation has been released yet for this SoC, so for now only the
bare minimum has been added in the DT.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt  |  7 +++
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      | 69 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   | 48 +++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 48 +++++++++++++++
 5 files changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index fcc6f6c..7edb635 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -17,6 +17,10 @@ Boards with the Amlogic Meson GXBaby SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,meson-gxbb";
 
+Boards with the Amlogic Meson GXL S905X SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,s905x", "amlogic,meson-gxl";
+
 Board compatible values:
   - "geniatech,atv1200" (Meson6)
   - "minix,neo-x8" (Meson8)
@@ -28,3 +32,6 @@ Board compatible values:
   - "hardkernel,odroid-c2" (Meson gxbb)
   - "amlogic,p200" (Meson gxbb)
   - "amlogic,p201" (Meson gxbb)
+  - "amlogic,p212" (Meson gxl s905x)
+  - "amlogic,p230" (Meson gxl s905d)
+  - "amlogic,p231" (Meson gxl s905d)
diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 47ec703..1f78b07 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-p201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
new file mode 100644
index 0000000..9639f01
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
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
+
+#include "meson-gxl-s905x.dtsi"
+
+/ {
+	compatible = "amlogic,p212", "amlogic,s905x", "amlogic,meson-gxl";
+	model = "Amlogic Meson GXL (S905X) P212 Development Board";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+/* This UART is brought out to the DB9 connector */
+&uart_AO {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
new file mode 100644
index 0000000..07f0e0b
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
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
+#include "meson-gxl.dtsi"
+
+/ {
+	compatible = "amlogic,s905x", "amlogic,meson-gxl";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
new file mode 100644
index 0000000..13b10ee
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
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
+#include "meson-gx.dtsi"
+
+/ {
+	compatible = "amlogic,meson-gxl";
+};
-- 
1.9.1
