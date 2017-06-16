From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:45 +0200
Subject: [PATCH 5/6] ARM: dts: iwg20d-q7: Add support for iWave G20D-Q7 board
 based on RZ/G1M
In-Reply-To: <cover.1497618353.git.horms+renesas@verge.net.au>
References: <cover.1497618353.git.horms+renesas@verge.net.au>
Message-ID: <ad2c0558d0494b420cadd6e887ddab2cd4e27e48.1497618353.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for iWave RainboW-G20D-Qseven board based on RZ/G1M.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9d64197f3e91..77d7e2db2513 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -705,6 +705,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r7s72100-rskrza1.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7743-iwg20d-q7.dtb \
 	r8a7743-sk-rzg1m.dtb \
 	r8a7745-sk-rzg1e.dtb \
 	r8a7778-bockw.dtb \
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
new file mode 100644
index 000000000000..9b54783cc2a5
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -0,0 +1,25 @@
+/*
+ * Device Tree Source for the iWave-RZG1M Qseven carrier board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7743-iwg20m.dtsi"
+
+/ {
+	model = "iWave Systems RainboW-G20D-Qseven board based on RZ/G1M";
+	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
+
+	aliases {
+		serial0 = &scif0;
+	};
+};
+
+&scif0 {
+	status = "okay";
+};
-- 
2.1.4
