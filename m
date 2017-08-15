From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 15 Aug 2017 11:54:19 +0100
Subject: [PATCH  1/2] ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM
In-Reply-To: <1502794460-30213-1-git-send-email-biju.das@bp.renesas.com>
References: <1502794460-30213-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502794460-30213-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for iWave RZG1E SODIMM System On Module.
http://www.iwavesystems.com/rz-g1e-sodimm-module.html

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22m.dtsi

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
new file mode 100644
index 0000000..9dbd854
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
1.9.1
