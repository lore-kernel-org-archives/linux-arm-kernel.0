From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 25 Apr 2014 02:42:41 +0400
Subject: [PATCH 1/2] ARM: shmobile: henninger: initial device tree
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <201404250242.42725.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device tree for the R8A7791 SoC based Henninger board. SCIF0
serial port support is included, so that the serial console can work. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/Makefile              |    1 
 arch/arm/boot/dts/r8a7791-henninger.dts |   50 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

Index: renesas/arch/arm/boot/dts/Makefile
===================================================================
--- renesas.orig/arch/arm/boot/dts/Makefile
+++ renesas/arch/arm/boot/dts/Makefile
@@ -321,6 +321,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
+	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
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
