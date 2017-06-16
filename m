From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:44 +0200
Subject: [PATCH 4/6] ARM: dts: iwg20m: Add iWave RZG1M Qseven SOM
In-Reply-To: <cover.1497618353.git.horms+renesas@verge.net.au>
References: <cover.1497618353.git.horms+renesas@verge.net.au>
Message-ID: <aabf13bac0046a1add4a3c39881ffb0abe692542.1497618353.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for iWave RZG1M Qseven System On Module.
http://www.iwavesystems.com/rz-g1m-qseven-module.html

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20m.dtsi

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
new file mode 100644
index 000000000000..001ca9144f4b
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -0,0 +1,29 @@
+/*
+ * Device Tree Source for the iWave-RZG1M-20M Qseven SOM
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "r8a7743.dtsi"
+
+/ {
+	compatible = "iwave,g20m", "renesas,r8a7743";
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x20000000>;
+	};
+
+	memory at 200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x20000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
-- 
2.1.4
