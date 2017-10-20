From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:07 +0200
Subject: [PATCH 04/31] arm64: dts: renesas: initial Eagle board device tree
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <1a48290edf6f78962b1d96008aea954b7b3e5969.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the initial device  tree for  the R8A77970 SoC based Eagle board.
The board has 1 debug serial port (SCIF0); include support for it,
so that the serial console can work.

Based on the original (and large) patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile           |  1 +
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 45 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 381928bc1358..96a3b29dce68 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb r8a7795-es1-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
+dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
new file mode 100644
index 000000000000..a4d1d4f24675
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -0,0 +1,45 @@
+/*
+ * Device Tree Source for the Eagle board
+ *
+ * Copyright (C) 2016-2017 Renesas Electronics Corp.
+ * Copyright (C) 2017 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a77970.dtsi"
+
+/ {
+	model = "Renesas Eagle board based on r8a77970";
+	compatible = "renesas,eagle", "renesas,r8a77970";
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
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&scif0 {
+	status = "okay";
+};
-- 
2.11.0
