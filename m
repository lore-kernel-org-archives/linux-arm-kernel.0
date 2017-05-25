From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 25 May 2017 17:28:20 +0800
Subject: [PATCH 3/4] arm64: dts: mt7622: add dts file for MT7622 reference
 board variant 1
In-Reply-To: <cover.1495703415.git.sean.wang@mediatek.com>
References: <cover.1495703415.git.sean.wang@mediatek.com>
Message-ID: <cadd96535300abd2cf7db724aa3d8aa0d17c6a9d.1495703415.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add the support for the MT7622 reference board variant 1 from
MediaTek.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile        |  1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 9fbfd32..e71456a2 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
new file mode 100644
index 0000000..e052ab5
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: Ming Huang <ming.huang@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+#include "mt7622.dtsi"
+
+/ {
+	model = "MediaTek MT7622 RFB1 board";
+	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n1";
+	};
+
+	memory {
+		reg = <0 0x40000000 0 0x3F000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.9.1
