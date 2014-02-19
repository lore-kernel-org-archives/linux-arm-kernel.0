From: b20788@freescale.com (Anson Huang)
Date: Wed, 19 Feb 2014 15:53:52 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sx: add initial imx6sx sdb support
In-Reply-To: <1392796432-19127-1-git-send-email-b20788@freescale.com>
References: <1392796432-19127-1-git-send-email-b20788@freescale.com>
Message-ID: <1392796432-19127-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial imx6sx sdb board support with uart and usdhc enabled.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts |   41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dts

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
new file mode 100644
index 0000000..3db4750
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "imx6sx.dtsi"
+
+/ {
+	model = "Freescale i.MX6 SoloX SDB Board";
+	compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
+
+	memory {
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_1>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+};
-- 
1.7.9.5
