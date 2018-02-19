From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 19 Feb 2018 19:20:55 +0100
Subject: [PATCH v2] arm64: dts: renesas: Add support for Salvator-XS with
 R-Car M3-N
Message-ID: <1519064455-12505-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Add initial support for the Renesas Salvator-XS (Salvator-X 2nd version)
development board equipped with an R-Car M3-N SiP.

Most features are enabled through the shared salvator-xs.dtsi board
description.  The memory configuration is specific to the M3-N SiP.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Switch to SPDX-License-Identifier, update patch description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix patch prefix.
---
 arch/arm64/boot/dts/renesas/Makefile                |  2 +-
 .../arm64/boot/dts/renesas/r8a77965-salvator-xs.dts | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 3680ecd638c44482..e9b525123a2e5f9a 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -7,6 +7,6 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
-dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-salvator-x.dtb
+dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-salvator-x.dtb r8a77965-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
new file mode 100644
index 0000000000000000..8a45fc43348d9adc
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Salvator-X 2nd version board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a77965.dtsi"
+#include "salvator-xs.dtsi"
+
+/ {
+	model = "Renesas Salvator-X 2nd version board based on r8a77965";
+	compatible = "renesas,salvator-xs", "renesas,r8a77965";
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
-- 
2.7.4
