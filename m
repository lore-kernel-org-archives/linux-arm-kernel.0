From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu, 25 Aug 2016 11:31:15 -0400
Subject: [PATCH] ARM: dts: rskrza1: initial device tree
Message-ID: <20160825153115.15291-1-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device tree for the RZ/A1 based development board (RSK).

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm/boot/dts/r7s72100-rskrza1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faacd52..c1c4d912 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -651,6 +651,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r7s72100-rskrza1.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
new file mode 100644
index 0000000..df9b979e
--- /dev/null
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -0,0 +1,53 @@
+/*
+ * Device Tree Source for the RZ/A1H RSK board
+ *
+ * Copyright (C) 2016 Renesas Electronics
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r7s72100.dtsi"
+
+/ {
+	model = "RSKRZA1";
+	compatible = "renesas,rskrza1", "renesas,r7s72100";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 8000000 {
+		device_type = "memory";
+		reg = <0x08000000 0x02000000>;
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <13330000>;
+};
+
+&usb_x1_clk {
+	clock-frequency = <48000000>;
+};
+
+&mtu2 {
+	status = "okay";
+};
+
+&scif2 {
+	status = "okay";
+};
+
-- 
2.9.2
