From: b35083@freescale.com (Jingchang Lu)
Date: Tue, 28 May 2013 17:12:23 +0800
Subject: [PATCH v4 4/4] ARM: dts: add initial VF610 Tower board dts support
In-Reply-To: <1369732343-2982-1-git-send-email-b35083@freescale.com>
References: <1369732343-2982-1-git-send-email-b35083@freescale.com>
Message-ID: <1369732343-2982-5-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial Freescale Vybrid VF610 Tower board support
with uart and fec enabled.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
v4:
  Follow internal suggestions to name the soc name as VF610.
  Remove node of QuadSPI, I2C, SAI, and sound until driver accepted.
v3:
  Split DTS support to SoC and board patches.
  Sort node by alphabet order of labels.

 arch/arm/boot/dts/Makefile      |  3 ++-
 arch/arm/boot/dts/vf610-twr.dts | 57 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/vf610-twr.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ca3f3fc..2042803 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -126,7 +126,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-sbc6x.dtb \
-	imx6sl-evk.dtb
+	imx6sl-evk.dtb \
+	vf610-twr.dtb
 dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx23-olinuxino.dtb \
 	imx23-stmp378x_devb.dtb \
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
new file mode 100644
index 0000000..b3905f5
--- /dev/null
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/dts-v1/;
+#include "vf610.dtsi"
+
+/ {
+	model = "VF610 Tower Board";
+	compatible = "fsl,vf610-twr", "fsl,vf610";
+
+	chosen {
+		bootargs = "console=ttyLP1,115200";
+	};
+
+	memory {
+		reg = <0x80000000 0x8000000>;
+	};
+
+	clocks {
+		audio_ext {
+			compatible = "fixed-clock";
+			clock-frequency = <24576000>;
+		};
+
+		enet_ext {
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+};
+
+&fec0 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec0_1>;
+	status = "okay";
+};
+
+&fec1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1_1>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
-- 
1.8.0
