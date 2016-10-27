From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 28 Oct 2016 00:40:16 +0300
Subject: [PATCH v5 6/7] ARM: dts: sk-rzg1m: initial device tree
In-Reply-To: <1580369.yToZzJza1l@wasted.cogentembedded.com>
References: <1580369.yToZzJza1l@wasted.cogentembedded.com>
Message-ID: <1978824.yG90jsYNe4@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device  tree for the R8A7743 SoC based SK-RZG1M board.
The board has one debug serial port (SCIF0); include support for it, so
that  the serial  console  can work.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 4:
- refreshed the patch.

Changes in version 3:
- added Geert's tag.

 arch/arm/boot/dts/Makefile             |    1 
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts |   44 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

Index: renesas/arch/arm/boot/dts/Makefile
===================================================================
--- renesas.orig/arch/arm/boot/dts/Makefile
+++ renesas/arch/arm/boot/dts/Makefile
@@ -677,6 +677,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r7s72100-rskrza1.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7743-sk-rzg1m.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
Index: renesas/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
@@ -0,0 +1,44 @@
+/*
+ * Device Tree Source for the SK-RZG1M board
+ *
+ * Copyright (C) 2016 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7743.dtsi"
+
+/ {
+	model = "SK-RZG1M";
+	compatible = "renesas,sk-rzg1m", "renesas,r8a7743";
+
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	memory at 200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&scif0 {
+	status = "okay";
+};
