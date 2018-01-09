From: s.riedmueller@phytec.de (Stefan Riedmueller)
Date: Tue, 9 Jan 2018 17:09:58 +0100
Subject: [PATCH v5 4/6] ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6
 DualLight/Solo RDK
In-Reply-To: <1515514200-9801-1-git-send-email-s.riedmueller@phytec.de>
References: <1515514200-9801-1-git-send-email-s.riedmueller@phytec.de>
Message-ID: <1515514200-9801-5-git-send-email-s.riedmueller@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christian Hemp <c.hemp@phytec.de>

Add support for the PHYTEC phyBOARD-Mira Low-Cost Rapid Development Kit
with i.MX 6DualLight/Solo with NAND.

Following interfaces are supported:
- 100 MBit Ethernet
- USB Host
- RS232
- HDMI

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
Signed-off-by: Stefan Christ <s.christ@phytec.de>
Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts | 64 +++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b793617..07d99a1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -388,6 +388,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-icore-rqs.dtb \
 	imx6dl-nit6xlite.dtb \
 	imx6dl-nitrogen6x.dtb \
+	imx6dl-phytec-mira-rdk-nand.dtb \
 	imx6dl-phytec-pbab01.dtb \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
new file mode 100644
index 0000000..a8adcb2
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 PHYTEC Messtechnik GmbH
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-phytec-phycore-som.dtsi"
+#include "imx6qdl-phytec-mira.dtsi"
+
+/ {
+	model = "PHYTEC phyBOARD-Mira DualLite/Solo Carrier-Board with NAND";
+	compatible = "phytec,imx6dl-pbac06-nand", "phytec,imx6dl-pbac06",
+		     "phytec,imx6qdl-pcm058", "fsl,imx6dl";
+
+	chosen {
+		linux,stdout-path = &uart2;
+	};
+};
+
+&ethphy {
+	max-speed = <100>;
+};
+
+&fec {
+	status = "okay";
+};
+
+&gpmi {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c_rtc {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+&usdhc1 {
+	status = "okay";
+};
-- 
2.7.4
