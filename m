From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 14 Jul 2018 21:37:24 +0200
Subject: [PATCH v2 4/5] ARM64: dts: meson-gxl: add support for the S905W SoC
 and the P281 board
In-Reply-To: <20180714193725.17837-1-martin.blumenstingl@googlemail.com>
References: <20180714193725.17837-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180714193725.17837-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S905W is a new SoC from the GXL series. It is a cost-reduced version of
the S905X.
The P281 development board from Amlogic uses the same layout as the P231
(S905D development board). Thus the new P281 board inherits
meson-gx-p23x-q20x.dtsi to avoid code-duplication.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-gxl-s905w-p281.dts | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 4dcffb0e3536..e55156dec237 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
new file mode 100644
index 000000000000..6509c4950950
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
+ * Based on meson-gxl-s905d-p231.dts:
+ * - Copyright (c) 2016 Endless Computers, Inc.
+ *   Author: Carlo Caione <carlo@endlessm.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905x.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+
+/ {
+	compatible = "amlogic,p281", "amlogic,s905w", "amlogic,meson-gxl";
+	model = "Amlogic Meson GXL (S905W) P281 Development Board";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+};
-- 
2.18.0
