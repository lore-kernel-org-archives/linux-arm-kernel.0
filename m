From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 31 Jul 2017 15:36:37 +0800
Subject: [PATCH v5 04/10] arm: dts: mt7623: rename mt7623-evb.dts to
 arch/arm/boot/dts/mt7623n-rfb.dtsi
In-Reply-To: <cover.1501486190.git.sean.wang@mediatek.com>
References: <cover.1501486190.git.sean.wang@mediatek.com>
Message-ID: <0b28cd1badefb581d84a50ea664772bb113eb0f0.1501486190.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

There are 2 versions of the MT7623 SoC, the one is MT7623N and the other
is MT7623A.  MT7623N is almost identical to MT7623A but has some
additional multimedia features. The reference boards are available as
NAND or MMC and might have a different ethernet setup. In order to reduce
the duplication of devicetree code we add an intermediate dtsi file for
these reference boards. Additionally MediaTek pointed out, that the EVB
is yet another board and the board in question is infact the RFB. Take
this into account while renaming the files.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/Makefile                          |  2 +-
 arch/arm/boot/dts/mt7623n-rfb-nand.dts              | 21 +++++++++++++++++++++
 .../boot/dts/{mt7623-evb.dts => mt7623n-rfb.dtsi}   |  8 +++-----
 3 files changed, 25 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
 rename arch/arm/boot/dts/{mt7623-evb.dts => mt7623n-rfb.dtsi} (87%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35..f3a2442 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1049,7 +1049,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
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
index 0000000..ba7d1ab
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: John Crispin <john@phrozen.org>
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
similarity index 87%
rename from arch/arm/boot/dts/mt7623-evb.dts
rename to arch/arm/boot/dts/mt7623n-rfb.dtsi
index 0686ad7..805ba69 100644
--- a/arch/arm/boot/dts/mt7623-evb.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -1,6 +1,7 @@
 /*
- * Copyright (c) 2016 MediaTek Inc.
+ * Copyright (c) 2017 MediaTek Inc.
  * Author: John Crispin <john@phrozen.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,9 +18,6 @@
 #include "mt6323.dtsi"
 
 / {
-	model = "MediaTek MT7623 evaluation board";
-	compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
-
 	chosen {
 		stdout-path = &uart2;
 	};
@@ -42,7 +40,7 @@
 		};
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
-- 
2.7.4
