From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:16 +0200
Subject: [PATCH 08/11] arm64: dts: renesas: Add common Salvator-XS board
 support
In-Reply-To: <cover.1497617276.git.horms+renesas@verge.net.au>
References: <cover.1497617276.git.horms+renesas@verge.net.au>
Message-ID: <0764c67f7fb37268937be392426f1d907d99a94a.1497617276.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Renesas Salvator-XS (Salvator-X 2nd version) development board can
be equipped with either an R-Car H3 ES2.0 or M3-W ES1.x SiP, which are
pin-compatible.

Add initial support for the common parts of the Salvator-XS board into
its own .dtsi file, to be included by the DTSes for the H3/M3-W
versions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/salvator-xs.dtsi

diff --git a/arch/arm64/boot/dts/renesas/salvator-xs.dtsi b/arch/arm64/boot/dts/renesas/salvator-xs.dtsi
new file mode 100644
index 000000000000..81227e3c2c6f
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/salvator-xs.dtsi
@@ -0,0 +1,20 @@
+/*
+ * Device Tree Source for the Salvator-X 2nd version board
+ *
+ * Copyright (C) 2015-2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "salvator-common.dtsi"
+
+/ {
+	model = "Renesas Salvator-X 2nd version board";
+	compatible = "renesas,salvator-xs";
+};
+
+&extal_clk {
+	clock-frequency = <16640000>;
+};
-- 
2.1.4
