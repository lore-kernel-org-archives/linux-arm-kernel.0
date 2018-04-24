From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 24 Apr 2018 11:19:36 +0200
Subject: [PATCH 2/2] ARM64: dts: allwinner: Add dts file for Libre Computer
 Board ALL-H3-CC H5 ver.
In-Reply-To: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1524561576-2201-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
Pi B+ form factor single board computer based on the Allwinner H2+, H3, or H5
SoCs with the same PCB.
The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
and connectors are in the exact same position as on the Raspberry Pi B+.

This patch enables the H5 variant using the H3 board definition moved to
a common dtsi in an earlier patch. The dts simply include the common dtsi
and declares the correct compatible and model of the H5 variant.

Suggested-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/allwinner/Makefile                     |  1 +
 .../boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 8bebe7d..7e07c07 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
new file mode 100644
index 0000000..95e113c
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+#include "sun50i-h5.dtsi"
+#include <arm/sunxi-libretech-all-h3-cc.dtsi>
+
+/ {
+	model = "Libre Computer Board ALL-H3-CC H5";
+	compatible = "libretech,all-h3-cc-h5", "allwinner,sun50i-h5";
+};
-- 
2.7.4
