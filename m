From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu,  7 Jun 2018 19:21:31 +0530
Subject: [PATCH 1/3] ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI
 starter kit support
Message-ID: <20180607135133.3104-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.CoreM6 1.5 is an another i.CoreM6 QDL cpu modules which can be connected
to EDIMM starter kit design with eMMC and MIPI-CSI interfaces suitable for
Android and video capture application.

notable features:
CPU                 NXP i.MX6 S/DL/D/Q, Up to 4 x Cortex-A9 at 800MHz
Memory              Up to 2 GB DDR3-1066
Video Interfaces    Up to 1 Parallel Up to 2 LVDS HDMI 1.4
                    port 8 bit CSI INPUT MIPI-CSI INPUT
1 x 10/100 Ethernet interface, 2 x USB, 1 x PCIe, 1 x I2S etc

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/imx6dl-icore-mipi.dts | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore-mipi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..2dead792ba9d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -400,6 +400,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-hummingboard2-emmc-som-v15.dtb \
 	imx6dl-hummingboard2-som-v15.dtb \
 	imx6dl-icore.dtb \
+	imx6dl-icore-mipi.dtb \
 	imx6dl-icore-rqs.dtb \
 	imx6dl-mamoj.dtb \
 	imx6dl-nit6xlite.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
new file mode 100644
index 000000000000..bf53f0552aa1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Engicam S.r.l.
+ * Copyright (C) 2018 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-icore.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 DualLite/Solo MIPI Starter Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6dl";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&usdhc3 {
+	status = "okay";
+};
-- 
2.14.3
