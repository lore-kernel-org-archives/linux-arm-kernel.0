From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:05 +0200
Subject: [PATCH 13/48] ARM: dts: iwg22d-sodimm: Add support for iWave
 G22D-SODIMM board
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <a59eb272a4eae10eb4f7a3e7b15aa47d57b32699.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for iWave RainboW-G22D-SODIMM board based on RZ/G1E.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faf46abaa4a2..e87f311ee9f2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -725,6 +725,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7740-armadillo800eva.dtb \
 	r8a7743-iwg20d-q7.dtb \
 	r8a7743-sk-rzg1m.dtb \
+	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-sk-rzg1e.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
new file mode 100644
index 000000000000..cbc19feb1565
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
2.1.4
