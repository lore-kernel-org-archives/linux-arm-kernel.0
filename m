From: ibanezchen@gmail.com (Howard Chen)
Date: Thu, 13 Nov 2014 00:07:35 +0800
Subject: [PATCH v6 2/4] ARM: mediatek: add dts for mt6592-evb
In-Reply-To: <1415808457-4030-1-git-send-email-ibanezchen@gmail.com>
References: <1415808457-4030-1-git-send-email-ibanezchen@gmail.com>
Message-ID: <1415808457-4030-2-git-send-email-ibanezchen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt6592-evb is an evaluation board based on the MT6592 SoC.

Signed-off-by: Howard Chen <ibanezchen@gmail.com>
---
 arch/arm/boot/dts/Makefile       |  3 ++-
 arch/arm/boot/dts/mt6592-evb.dts | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mt6592-evb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ab63751..0ce0d9e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -532,7 +532,8 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
 	dove-d2plug.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb \
+	mt6592-evb.dtb
 
 endif
 
diff --git a/arch/arm/boot/dts/mt6592-evb.dts b/arch/arm/boot/dts/mt6592-evb.dts
new file mode 100644
index 0000000..4750c4c
--- /dev/null
+++ b/arch/arm/boot/dts/mt6592-evb.dts
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Howard Chen <ibanezchen@gmail.com>
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
+#include "mt6592.dtsi"
+
+/ {
+	model = "mt6592 evb";
+	compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
+
+	memory {
+		reg = <0x80000000 0x08000000>;
+	};
+};
-- 
1.9.1
