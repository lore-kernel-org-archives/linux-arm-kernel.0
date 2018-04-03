From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  3 Apr 2018 12:19:39 +0100
Subject: [PATCH v3 3/3] ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC
 based on RZ/G1C
In-Reply-To: <1522754379-64116-1-git-send-email-biju.das@bp.renesas.com>
References: <1522754379-64116-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1522754379-64116-4-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for iWave iW-RainboW-G23S single board computer based on
 RZ/G1C.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V1->V2:
* Incorporated review comments
V2->V3:
* No Change

 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 35 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2b6dfee..4291638 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -781,6 +781,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
 	r8a7745-sk-rzg1e.dtb \
+	r8a77470-iwg23s-sbc.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
new file mode 100644
index 0000000..d21baad
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -0,0 +1,35 @@
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
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial1:115200n8";
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
