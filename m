From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Aug 2012 18:02:24 +0200
Subject: [PATCH] ARM: dts: mxs: Add the second I2C adapter to the CFA10049
 expansion board
Message-ID: <1346169744-24674-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-cfa10049.dts

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
new file mode 100644
index 0000000..e0e4b8c
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2012 Free Electrons
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/*
+ * The CFA-10049 is an expansion board for the CFA-10036 module, thus we
+ * need to include the CFA-10036 DTS.
+ */
+/include/ "imx28-cfa10036.dts"
+
+/ {
+	model = "Crystalfontz CFA-10049 Board";
+	compatible = "crystalfontz,cfa10049", "crystalfontz,cfa10036", "fsl,imx28";
+
+	apb at 80000000 {
+		apbx at 80040000 {
+			i2c1: i2c at 8005a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c1_pins_a>;
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.7.9.5
