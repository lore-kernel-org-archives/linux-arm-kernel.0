From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  1 Jun 2013 09:54:13 +0400
Subject: [PATCH 4/4] ARM: dts: imx27-phytec-phycore-som: Add initial support
 for PCM970 RDK
In-Reply-To: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
References: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370066053-25030-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds initial dts for Phytec PCM970 Rapid development kit.
- Added definition for UART0 and UART1.
- Added additional SPI chipselect which used on RDK for ZegBee module.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile                     |  1 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 29 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8450c14..eee371f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -108,6 +108,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-apf27dev.dtb \
 	imx27-pdk.dtb \
 	imx27-phytec-phycore-som.dtb \
+	imx27-phytec-phycore-rdk.dtb \
 	imx31-bug.dtb \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
new file mode 100644
index 0000000..f8a7a49
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -0,0 +1,29 @@
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "imx27-phytec-phycore-som.dts"
+
+/ {
+	model = "Phytec pcm970";
+	compatible = "phytec,imx27-pcm970", "phytec,imx27-pcm038", "fsl,imx27";
+};
+
+&cspi1 {
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
+};
+
+&uart1 {
+	fsl,uart-has-rtscts;
+};
+
+&uart2 {
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
-- 
1.8.1.5
