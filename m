From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  2 Jun 2017 17:22:02 +0100
Subject: [PATCH  3/4] ARM: dts: iwg20m: Add iWave RZG1M Qseven SOM
In-Reply-To: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
References: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1496420523-23506-4-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for iWave RZG1M Qseven System On Module.
http://www.iwavesystems.com/rz-g1m-qseven-module.html

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20m.dtsi

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
new file mode 100644
index 0000000..d7bdf5d
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -0,0 +1,27 @@
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
1.9.1
