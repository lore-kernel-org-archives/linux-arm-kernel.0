From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 27 Mar 2018 15:37:21 +0100
Subject: [PATCH 10/12] ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC
 based on RZ/G1C
In-Reply-To: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
References: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1522161443-54428-11-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for iWave iW-RainboW-G23S single board computer based on
 RZ/G1C.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3b4cc1b..3e4df0d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -795,6 +795,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
 	r8a7745-sk-rzg1e.dtb \
+	r8a77470-iwg23s-sbc.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
new file mode 100644
index 0000000..ebbfb36
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave-RZ/G1C single board computer
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a77470.dtsi"
+/ {
+	model = "iWave iW-RainboW-G23S single board computer based on RZ/G1C";
+	compatible = "iwave,g23s", "renesas,r8a77470";
+
+	aliases {
+		serial1 = &scif1;
+	};
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
+
+&scif1 {
+	status = "okay";
+};
-- 
2.7.4
