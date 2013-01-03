From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 3 Jan 2013 14:27:35 -0200
Subject: [PATCH v2] ARM: mx25pdk: Add device tree support
Message-ID: <1357230455-12690-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic device tree support for mx25pdk board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Follow the new dt style and rebased against Shawn's imx/dt tree.

 Documentation/devicetree/bindings/arm/fsl.txt |    4 +++
 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/imx25-pdk.dts               |   36 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx25-pdk.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 4c25c98..e935d7d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -5,6 +5,10 @@ i.MX23 Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx23-evk", "fsl,imx23";
 
+i.MX25 Product Development Kit
+Required root node properties:
+    - compatible = "fsl,imx25-pdk", "fsl,imx25";
+
 i.MX27 Product Development Kit
 Required root node properties:
     - compatible = "fsl,imx27-pdk", "fsl,imx27";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e3ae5e2..ffcdb61 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-xp-openblocks-ax3-4.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-karo-tx25.dtb \
+	imx25-pdk.dtb \
 	imx27-apf27.dtb \
 	imx27-pdk.dtb \
 	imx31-bug.dtb \
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
new file mode 100644
index 0000000..b430ed7
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx25.dtsi"
+
+/ {
+	model = "Freescale i.MX25 Product Development Kit";
+	compatible = "fsl,imx25-pdk", "fsl,imx25";
+
+	memory {
+		reg = <0x80000000 0x4000000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&fec {
+	status = "okay";
+	phy-mode = "rmii";
+};
+
+&nfc {
+	nand-on-flash-bbt;
+	status = "okay";
+};
-- 
1.7.9.5
