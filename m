From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:22:50 +0200
Subject: [PATCH] ARM: dts: meson-gxbb: Add support for the Nexbox A95X Board
Message-ID: <1471951370-29269-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 79 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 47ec703..2c50439 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-p201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
new file mode 100644
index 0000000..c418bd7
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -0,0 +1,79 @@
+/*
+ * Copyright (c) 2016 Andreas F?rber
+ * Copyright (c) 2016 BayLibre, Inc.
+ * Author: Neil Armstrong <narmstrong@kernel.org>
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
+#include "meson-gxbb.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "nexbox,a95x", "amlogic,meson-gxbb";
+	model = "NEXBOX A95X";
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
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+};
+
-- 
1.9.1
