From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 04 Jun 2016 00:35:56 +0300
Subject: [PATCH v2 10/11] ARM: dts: blanche: initial device tree
In-Reply-To: <3446154.oZ24315zaL@wasted.cogentembedded.com>
References: <3446154.oZ24315zaL@wasted.cogentembedded.com>
Message-ID: <13571934.l66Gg7Cpm9@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device  tree for the R8A7792 SoC based Blanche board.
The board has 2 debug serial ports: SCIF0 and SCIF3; include support for
them,  so that  the serial console  can  work.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- added Simon's ACK and Geert's tag too.

 arch/arm/boot/dts/Makefile            |    1 
 arch/arm/boot/dts/r8a7792-blanche.dts |   44 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

Index: renesas/arch/arm/boot/dts/Makefile
===================================================================
--- renesas.orig/arch/arm/boot/dts/Makefile
+++ renesas/arch/arm/boot/dts/Makefile
@@ -638,6 +638,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7790-lager.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7791-porter.dtb \
+	r8a7792-blanche.dtb \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -0,0 +1,44 @@
+/*
+ * Device Tree Source for the Blanche board
+ *
+ * Copyright (C) 2016 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7792.dtsi"
+
+/ {
+	model = "Blanche";
+	compatible = "renesas,blanche", "renesas,r8a7792";
+
+	aliases {
+		serial0 = &scif0;
+		serial1 = &scif3;
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
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&scif0 {
+	status = "okay";
+};
+
+&scif3 {
+	status = "okay";
+};
