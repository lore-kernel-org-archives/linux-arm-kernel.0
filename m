From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Apr 2014 11:15:31 +0900
Subject: [PATCH 1/3] ARM: shmobile: henninger: initial device tree
In-Reply-To: <cover.1398737464.git.horms+renesas@verge.net.au>
References: <cover.1398737464.git.horms+renesas@verge.net.au>
Message-ID: <4b37ab033e6f8c9750f98fefe9bdc341b6943268.1398737464.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the initial device tree for the R8A7791 SoC based Henninger board. SCIF0
serial port support is included, so that the serial console can work.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/r8a7791-henninger.dts | 50 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-henninger.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35c146f..2e9b6e0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -322,6 +322,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
+	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
new file mode 100644
index 0000000..0053f52
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -0,0 +1,50 @@
+/*
+ * Device Tree Source for the Henninger board
+ *
+ * Copyright (C) 2014 Renesas Solutions Corp.
+ * Copyright (C) 2014 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7791.dtsi"
+
+/ {
+	model = "Henninger";
+	compatible = "renesas,henninger", "renesas,r8a7791";
+
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		bootargs = "console=ttySC0,38400 ignore_loglevel";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	memory at 200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
+	};
+};
+
+&pfc {
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data_d";
+		renesas,function = "scif0";
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
1.8.5.2
