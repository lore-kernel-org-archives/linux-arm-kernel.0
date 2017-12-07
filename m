From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:54 +0100
Subject: [PATCH 51/54] arm64: dts: renesas: initial V3MSK board device tree
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <cc3e267e9bb0ce7fead857f9258268ffa5f51b91.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the initial device  tree for the V3M Starter Kit board.
The board has 1 debug serial port (SCIF0); include support for it,
so that the serial console can work.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile           |  2 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts | 44 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 7f13e014d0aa..2186d0193b73 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -7,5 +7,5 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
-dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb
+dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
new file mode 100644
index 000000000000..50f49212f54e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -0,0 +1,44 @@
+/*
+ * Device Tree Source for the V3M Starter Kit board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
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
+	model = "Renesas V3M Starter Kit board";
+	compatible = "renesas,v3msk", "renesas,r8a77970";
+
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
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
