From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:04 +0200
Subject: [PATCH 12/48] ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <c9a41f515d1e5955c44cb04926f5f5f4be4a0cd0.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for iWave RZG1E SODIMM System On Module.
http://www.iwavesystems.com/rz-g1e-sodimm-module.html

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22m.dtsi

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
new file mode 100644
index 000000000000..9dbd854aacf8
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -0,0 +1,24 @@
+/*
+ * Device Tree Source for the iWave-RZG1E-G22M SODIMM SOM
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "r8a7745.dtsi"
+
+/ {
+	compatible = "iwave,g22m", "renesas,r8a7745";
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x20000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
-- 
2.1.4
