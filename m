From: taoren@fb.com (Tao Ren)
Date: Mon, 5 Nov 2018 20:28:29 -0800
Subject: [PATCH v2 1/2] ARM: dts: Add Facebook BMC flash layout
Message-ID: <20181106042829.2771226-1-taoren@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the layout used by Facebook BMC systems. It describes the fixed
flash layout of a 32MB mtd device.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 Changes since v1:
  - adding facebook copyright.

 .../boot/dts/facebook-bmc-flash-layout.dtsi   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi

diff --git a/arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi b/arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi
new file mode 100644
index 000000000000..94039d7b7de5
--- /dev/null
+++ b/arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	u-boot at 0 {
+		reg = <0x0 0x60000>;
+		label = "u-boot";
+	};
+
+	u-boot-env at 60000 {
+		reg = <0x60000 0x20000>;
+		label = "env";
+	};
+
+	fit at 80000 {
+		reg = <0x80000 0x1b80000>;
+		label = "fit";
+	};
+
+	data0 at 1c00000 {
+		reg = <0x1c00000 0x400000>;
+		label = "data0";
+	};
+
+	flash0 at 0 {
+		reg = <0x0 0x2000000>;
+		label = "flash0";
+	};
+};
-- 
2.17.1
