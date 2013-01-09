From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  9 Jan 2013 14:44:25 +0100
Subject: [PATCH 4/4] ARM i.MX53: dts: add oftree for MBa53 baseboard
In-Reply-To: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1357739065-9153-5-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MBa53 is a baseboard for the TQMA53 embedded module. This enables/adds only
supported devices, i.e. it is not feature complete, because of missing drivers
in mainline linux.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/Makefile        |    1 +
 arch/arm/boot/dts/imx53-MBa53.dts |  146 +++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-MBa53.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..04b05e8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
 	imx53-evk.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx53-MBa53.dtb \
 	imx6q-arm2.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
diff --git a/arch/arm/boot/dts/imx53-MBa53.dts b/arch/arm/boot/dts/imx53-MBa53.dts
new file mode 100644
index 0000000..39ecaeb
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-MBa53.dts
@@ -0,0 +1,146 @@
+/*
+ * Copyright 2012 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
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
+/include/ "imx53-tqma53.dtsi"
+
+/ {
+	model = "TQ MBa53 starter kit";
+	compatible = "tq,mba53", "tq,tqma53", "fsl,imx53";
+
+	backlight_reg:fixed at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-supply";
+		gpio = <&gpio2 5 0>;
+		startup-delay-us = <5000>;
+		enable-active-low;
+        };
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 50000 0 0>;
+		brightness-levels = <0 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100>;
+		default-brightness-level = <10>;
+		enable-gpios = <&gpio7 7 0>;
+		power-supply = <&backlight_reg>;
+        };
+};
+
+&iomuxc {
+	lvds1 {
+		pinctrl_lvds1_1: lvds1-grp1 {
+			fsl,pins = <730 0x10000		/* LVDS0_TX3 */
+				    732 0x10000		/* LVDS0_CLK */
+				    734 0x10000		/* LVDS0_TX2 */
+				    736 0x10000		/* LVDS0_TX1 */
+				    738 0x10000>;	/* LVDS0_TX0 */
+		};
+
+		pinctrl_lvds1_2: lvds1-grp2 {
+			fsl,pins = <720 0x10000		/* LVDS1_TX3 */
+				    722 0x10000		/* LVDS1_TX2 */
+				    724 0x10000		/* LVDS1_CLK */
+				    726 0x10000		/* LVDS1_TX1 */
+				    728 0x10000>;	/* LVDS1_TX0 */
+		};
+	};
+
+	disp1 {
+		pinctrl_disp1_1: disp1-grp1 {
+			fsl,pins = <689 0x10000		/* DISP1_DRDY	*/
+				    482 0x10000		/* DISP1_HSYNC	*/
+				    489 0x10000		/* DISP1_VSYNC	*/
+				    684 0x10000		/* DISP1_DAT_0	*/
+				    515 0x10000		/* DISP1_DAT_22	*/
+				    523 0x10000		/* DISP1_DAT_23	*/
+				    543 0x10000		/* DISP1_DAT_21	*/
+				    553 0x10000		/* DISP1_DAT_20	*/
+				    558 0x10000		/* DISP1_DAT_19	*/
+				    564 0x10000		/* DISP1_DAT_18	*/
+				    570 0x10000		/* DISP1_DAT_17	*/
+				    575 0x10000		/* DISP1_DAT_16	*/
+				    580 0x10000		/* DISP1_DAT_15	*/
+				    585 0x10000		/* DISP1_DAT_14	*/
+				    590 0x10000		/* DISP1_DAT_13	*/
+				    595 0x10000		/* DISP1_DAT_12	*/
+				    628 0x10000		/* DISP1_DAT_11	*/
+				    634 0x10000		/* DISP1_DAT_10	*/
+				    639 0x10000		/* DISP1_DAT_9	*/
+				    644 0x10000		/* DISP1_DAT_8	*/
+				    649 0x10000		/* DISP1_DAT_7	*/
+				    654 0x10000		/* DISP1_DAT_6	*/
+				    659 0x10000		/* DISP1_DAT_5	*/
+				    664 0x10000		/* DISP1_DAT_4	*/
+				    669 0x10000		/* DISP1_DAT_3	*/
+				    674 0x10000		/* DISP1_DAT_2	*/
+				    679 0x10000		/* DISP1_DAT_1	*/
+				    684 0x10000>;	/* DISP1_DAT_0	*/
+		};
+	};
+};
+
+&cspi {
+	status = "okay";
+};
+
+&i2c2 {
+	codec: sgtl5000 at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+	};
+
+	expander: pca9554 at 20 {
+		compatible = "pca9554";
+		reg = <0x20>;
+		interrupts = <109>;
+	};
+
+	sensor2: lm75 at 49 {
+		compatible = "lm75";
+		reg = <0x49>;
+	};
+};
+
+&fec {
+	status = "okay";
+};
+
+&esdhc2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&ecspi1 {
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
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
-- 
1.7.10.4
