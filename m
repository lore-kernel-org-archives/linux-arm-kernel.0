From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed,  5 Oct 2016 16:27:34 +0200
Subject: [PATCH] arm64: dts: marvell: Add definition for the Globalscale
 Marvell ESPRESSOBin Board
Message-ID: <20161005142734.18995-1-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a basic definition for this board.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/Makefile               |  1 +
 .../boot/dts/marvell/armada-3720-espressobin.dts   | 78 ++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 308468d..392eeb6 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
 
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
new file mode 100644
index 0000000..57035a3
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -0,0 +1,78 @@
+/*
+ * Device Tree file for Globalscale Marvell ESPRESSOBin Board
+ * Copyright (C) 2016 Marvell
+ *
+ * Romain Perier <romain.perier@free-electrons.com>
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
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "armada-372x.dtsi"
+
+/ {
+	model = "Globalscale Marvell ESPRESSOBin Board";
+	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
-- 
2.9.3
