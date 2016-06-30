From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:47 +0200
Subject: [PATCH 27/41] ARM: dts: blanche: initial device tree
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <4018fba454602cc1d01a216352935d88582353f1.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the initial device  tree for the R8A7792 SoC based Blanche board.
The board has 2 debug serial ports: SCIF0 and SCIF3; include support for
them,  so that  the serial console  can  work.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/r8a7792-blanche.dts | 45 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7792-blanche.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 06b6c2d695bf..91630d1376bc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -638,6 +638,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7790-lager.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7791-porter.dtb \
+	r8a7792-blanche.dtb \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
new file mode 100644
index 000000000000..e277d924441b
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -0,0 +1,45 @@
+/*
+ * Device Tree Source for the Blanche board
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2016 Cogent  Embedded, Inc.
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
-- 
2.7.0.rc3.207.g0ac5344
