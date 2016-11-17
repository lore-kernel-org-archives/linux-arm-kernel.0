From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:40 +0100
Subject: [PATCH 23/31] ARM: dts: sk-rzg1e: initial device tree
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <9e7b824b5a384ad6d3adb0ca56bee4ee2fbfefba.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the initial  device tree for the R8A7745 SoC based SK-RZG1E board.
The board has 1  debug  serial  port (SCIF2); include support for it,
so that the serial console can  work.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f83ea57c97f9..6f8cd1436ee8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -678,6 +678,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7743-sk-rzg1m.dtb \
+	r8a7745-sk-rzg1e.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts b/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
new file mode 100644
index 000000000000..667ec4b259d5
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
@@ -0,0 +1,39 @@
+/*
+ * Device Tree Source for the SK-RZG1E board
+ *
+ * Copyright (C) 2016 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7745.dtsi"
+
+/ {
+	model = "SK-RZG1E";
+	compatible = "renesas,sk-rzg1e", "renesas,r8a7745";
+
+	aliases {
+		serial0 = &scif2;
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
+&scif2 {
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
