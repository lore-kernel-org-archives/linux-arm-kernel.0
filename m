From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Aug 2012 16:00:41 +0200
Subject: [PATCH 2/2] ARM: dts: mxs: Add the second I2C adapter to the CFA10049
 expansion board
In-Reply-To: <1346421641-3765-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346421641-3765-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1346421641-3765-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/Makefile.boot      |    1 +
 2 files changed, 32 insertions(+)
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
diff --git a/arch/arm/mach-mxs/Makefile.boot b/arch/arm/mach-mxs/Makefile.boot
index 4582999..8bd23a8 100644
--- a/arch/arm/mach-mxs/Makefile.boot
+++ b/arch/arm/mach-mxs/Makefile.boot
@@ -5,6 +5,7 @@ dtb-y += imx23-evk.dtb \
 	 imx23-stmp378x_devb.dtb \
 	 imx28-apx4devkit.dtb \
 	 imx28-cfa10036.dtb \
+	 imx28-cfa10049.dtb \
 	 imx28-evk.dtb \
 	 imx28-m28evk.dtb \
 	 imx28-tx28.dtb \
-- 
1.7.9.5
