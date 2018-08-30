From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Aug 2018 16:09:26 +0800
Subject: [PATCH 3/3] arm64: dts: allwinner: h5: Add device tree for Bananapi
 M2 Plus H5
In-Reply-To: <20180830080926.15027-1-wens@csie.org>
References: <20180830080926.15027-1-wens@csie.org>
Message-ID: <20180830080926.15027-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Bananapi M2 Plus H5 is a variant of the original Bananapi M2 Plus,
with the H3 SoC replaced with an H5. Everything else is the same.

Add a stub device tree incorporating the shared bananapi-m2-plus dtsi
file.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/Makefile                |  1 +
 .../boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index b7034327b28b..82335360499d 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts
new file mode 100644
index 000000000000..77661006dfba
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
+
+/dts-v1/;
+#include "sun50i-h5.dtsi"
+#include <arm/sunxi-bananapi-m2-plus.dtsi>
+
+/ {
+	model = "Banana Pi BPI-M2-Plus H5";
+	compatible = "sinovoip,bpi-m2-plus", "allwinner,sun50i-h5";
+};
-- 
2.18.0
