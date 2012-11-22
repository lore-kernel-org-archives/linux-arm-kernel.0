From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 22 Nov 2012 17:10:43 -0200
Subject: [PATCH 1/4] ARM: dts: Add very basic dt support for mx31pdk
Message-ID: <1353611447-7732-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add very basic dt support for mx31pdk.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    4 ++++
 arch/arm/boot/dts/Makefile                    |    3 ++-
 arch/arm/boot/dts/imx31-pdk.dts               |   30 +++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx31-pdk.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index ac9e751..50b931a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -9,6 +9,10 @@ i.MX28 Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx28-evk", "fsl,imx28";
 
+i.MX31 Product Development Kit
+Required root node properties:
+    - compatible = "fsl,imx31-pdk", "fsl,imx31";
+
 i.MX51 Babbage Board
 Required root node properties:
     - compatible = "fsl,imx51-babbage", "fsl,imx51";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 701388b..5b5590f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -59,7 +59,8 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-xp-db.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
+dtb-$(CONFIG_ARCH_MXC) += imx31-pdk.dtb \
+	imx51-babbage.dtb \
 	imx53-ard.dtb \
 	imx53-evk.dtb \
 	imx53-qsb.dtb \
diff --git a/arch/arm/boot/dts/imx31-pdk.dts b/arch/arm/boot/dts/imx31-pdk.dts
new file mode 100644
index 0000000..1e46d80
--- /dev/null
+++ b/arch/arm/boot/dts/imx31-pdk.dts
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+/include/ "imx31.dtsi"
+
+/ {
+	model = "mx31-pdk";
+	compatible = "freescale,imx31-pdk", "fsl,imx31";
+
+	memory {
+		reg = <0x80000000 0x8000000>;
+	};
+
+	soc {
+		aips at 43f00000 { /* AIPS1 */
+			uart1: serial at 43f90000 {
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.7.9.5
