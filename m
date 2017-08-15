From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 15 Aug 2017 11:54:20 +0100
Subject: [PATCH 2/2] ARM: dts: iwg22d-sodimm: Add support for iWave
 G22D-SODIMM board
In-Reply-To: <1502794460-30213-1-git-send-email-biju.das@bp.renesas.com>
References: <1502794460-30213-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502794460-30213-3-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for iWave RainboW-G22D-SODIMM board based on RZ/G1E.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35..51641d4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -715,6 +715,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7740-armadillo800eva.dtb \
 	r8a7743-iwg20d-q7.dtb \
 	r8a7743-sk-rzg1m.dtb \
+	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-sk-rzg1e.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
new file mode 100644
index 0000000..cbc19fe
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -0,0 +1,29 @@
+/*
+ * Device Tree Source for the iWave-RZG1E SODIMM carrier board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7745-iwg22m.dtsi"
+
+/ {
+	model = "iWave Systems RainboW-G22D-SODIMM board based on RZ/G1E";
+	compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745";
+
+	aliases {
+		serial0 = &scif4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&scif4 {
+	status = "okay";
+};
-- 
1.9.1
