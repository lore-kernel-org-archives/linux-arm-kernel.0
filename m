From: ibanezchen@gmail.com (Howard Chen)
Date: Wed,  8 Oct 2014 17:36:26 +0800
Subject: [PATCH 2/3] ARM: mediatek: add dts for mt6592-evb
In-Reply-To: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
References: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
Message-ID: <1412760987-1668-2-git-send-email-ibanezchen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt6592-evb is an evaluation board based on the MT6592 SoC.

Signed-off-by: Howard Chen <ibanezchen@gmail.com>
---
 arch/arm/boot/dts/mt6592-evb.dts | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt6592-evb.dts

diff --git a/arch/arm/boot/dts/mt6592-evb.dts b/arch/arm/boot/dts/mt6592-evb.dts
new file mode 100644
index 0000000..38f2560
--- /dev/null
+++ b/arch/arm/boot/dts/mt6592-evb.dts
@@ -0,0 +1,46 @@
+/*
+ * Copyright (c) 2014 Mediatek
+ * Author: Howard Chen <ibanezchen@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
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
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,921600n8";
+	};
+
+	memory {
+		reg = <0x80000000 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
-- 
1.9.1
