From: michal.simek@xilinx.com (Michal Simek)
Date: Wed,  2 May 2018 13:53:14 +0200
Subject: [PATCH] arm64: zynqmp: Add support for Avnet Ultra96 rev1 board
Message-ID: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avnet Ultra96 rev1 board is commercialized Xilinx zcu100 revC/D
internal board. The patch is reusing zcu100 revC files but changing
model description and compatible strings which are used for example by
libmraa.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I choose this option because there are houndreds of zcu100 boards
created and this will enable support both versions.

Record avnet prefix was sent by separate patch.
---
 arch/arm64/boot/dts/xilinx/Makefile           |  1 +
 .../boot/dts/xilinx/avnet-ultra96-rev1.dts    | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index d452f80e7601..60f5443f3ef4 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ZYNQMP) += avnet-ultra96-rev1.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1232-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1254-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1275-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
new file mode 100644
index 000000000000..88aa06fa78a8
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Avnet Ultra96 rev1
+ *
+ * (C) Copyright 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp-zcu100-revC.dts"
+
+/ {
+	model = "Avnet Ultra96 Rev1";
+	compatible = "avnet,ultra96-rev1", "avnet,ultra96",
+		     "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100",
+		     "xlnx,zynqmp";
+};
-- 
2.17.0
