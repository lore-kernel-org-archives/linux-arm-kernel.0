From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 19 Jan 2018 13:55:45 +0100
Subject: [PATCH 6/7] arm64: zynqmp: Add support for Xilinx zc12XX boards
In-Reply-To: <cover.1516366474.git.michal.simek@xilinx.com>
References: <cover.1516366474.git.michal.simek@xilinx.com>
Message-ID: <1cc1e046fe0fb25dd3d2ed3144dc7d03792bfd10.1516366474.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These 3 boards requires minimal support to get Linux up and running.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/Makefile               |  3 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts | 54 +++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts | 42 ++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts | 42 ++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index d15c9dc1d8f2..bdda451afaad 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1232-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1254-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1275-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
new file mode 100644
index 000000000000..0f7b4cf6078e
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZC1232
+ *
+ * (C) Copyright 2017 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP ZC1232 RevA";
+	compatible = "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232", "xlnx,zynqmp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+	/* SATA OOB timing settings */
+	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
new file mode 100644
index 000000000000..9092828f92ec
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZC1254
+ *
+ * (C) Copyright 2015 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP ZC1254 RevA";
+	compatible = "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254", "xlnx,zynqmp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
new file mode 100644
index 000000000000..4f404c580eec
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZC1275
+ *
+ * (C) Copyright 2017 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP ZC1275 RevA";
+	compatible = "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275", "xlnx,zynqmp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.9.1
