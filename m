From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 25 May 2017 12:02:42 +0800
Subject: [PATCH v4 4/9] arm: dts: mt7623: rename mt7623-evb.dts to
 arch/arm/boot/dts/mt7623n-rfb.dtsi
In-Reply-To: <cover.1495683769.git.sean.wang@mediatek.com>
References: <cover.1495683769.git.sean.wang@mediatek.com>
Message-ID: <85a70aae5de5f7aecfef05d5a11177133d1a9e38.1495683769.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

There are 2 versions of the MT7623 SoC, the one is MT7623n and the other
is MT7623a.  MT7623n is almost identical to MT7623a but has some
additional multimedia features. The reference boards are available as
NAND or MMC and might have a different ethernet setup. In order to reduce
the duplication of devicetree code we add an intermediate dtsi file for
these reference boards. Additionally Mediatek pointed out, that the EVB
is yet another board and the board in question is infact the RFB. Take
this into account while renaming the files.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/Makefile                          |  2 +-
 arch/arm/boot/dts/mt7623n-rfb-nand.dts              | 21 +++++++++++++++++++++
 .../boot/dts/{mt7623-evb.dts => mt7623n-rfb.dtsi}   |  8 ++------
 3 files changed, 24 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
 rename arch/arm/boot/dts/{mt7623-evb.dts => mt7623n-rfb.dtsi} (79%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c5e1d9..20a7c9d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1034,7 +1034,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
-	mt7623-evb.dtb \
+	mt7623n-rfb-nand.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
new file mode 100644
index 0000000..436d51c
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: John Crispin <blogic@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+#include "mt7623n-rfb.dtsi"
+
+/ {
+	model = "MediaTek MT7623N NAND reference board";
+	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
+};
diff --git a/arch/arm/boot/dts/mt7623-evb.dts b/arch/arm/boot/dts/mt7623n-rfb.dtsi
similarity index 79%
rename from arch/arm/boot/dts/mt7623-evb.dts
rename to arch/arm/boot/dts/mt7623n-rfb.dtsi
index a769149..c526116 100644
--- a/arch/arm/boot/dts/mt7623-evb.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -1,6 +1,6 @@
 /*
  * Copyright (c) 2016 MediaTek Inc.
- * Author: John Crispin <john@phrozen.org>
+ * Author: John Crispin <blogic@openwrt.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -12,18 +12,14 @@
  * GNU General Public License for more details.
  */
 
-/dts-v1/;
 #include "mt7623-mt6323.dtsi"
 
 / {
-	model = "MediaTek MT7623 evaluation board";
-	compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
-
 	chosen {
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
-- 
2.7.4
