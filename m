From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 13 Oct 2017 14:03:15 +0100
Subject: [PATCH 3/4] ARM: dts: iwg22d-sodimm-dbhd-ca: Add device tree for HDMI
 DB
In-Reply-To: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1507899796-7941-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add file r8a7745-iwg22d-sodimm-dbhd-ca.dts to provide support for
iW-RainboW-G22D with HDMI daughter board plugged in.

The interfaces defined in the new .dts file are: scif1, scif5,
and hscif2.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 61 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8c34d06..e27b194 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -727,6 +727,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7743-iwg20d-q7-dbcm-ca.dtb \
 	r8a7743-sk-rzg1m.dtb \
 	r8a7745-iwg22d-sodimm.dtb \
+	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
 	r8a7745-sk-rzg1e.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
new file mode 100644
index 0000000..f925388
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
@@ -0,0 +1,61 @@
+/*
+ * Device Tree Source for the iWave-RZG1E SODIMM carrier board + HDMI daughter
+ * board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "r8a7745-iwg22d-sodimm.dts"
+
+/ {
+	model = "iWave RainboW-G22D-SODIMM RZ/G1E based board with HDMI add-on";
+	compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745";
+
+	aliases {
+		serial0 = &scif1;
+		serial4 = &scif5;
+		serial6 = &hscif2;
+	};
+};
+
+&hscif2 {
+	pinctrl-0 = <&hscif2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pfc {
+	hscif2_pins: hscif2 {
+		groups = "hscif2_data";
+		function = "hscif2";
+	};
+
+	scif1_pins: scif1 {
+		groups = "scif1_data";
+		function = "scif1";
+	};
+
+	scif5_pins: scif5 {
+		groups = "scif5_data_d";
+		function = "scif5";
+	};
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif5 {
+	pinctrl-0 = <&scif5_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.7.4
