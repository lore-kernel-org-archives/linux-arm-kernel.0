From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 23 Mar 2013 14:04:23 +0100
Subject: [PATCH] ARM: zynq: add support for ZedBoard
Message-ID: <1364043863-20669-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the Avnet ZedBoard.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/Makefile          |  3 ++-
 arch/arm/boot/dts/zynq-zedboard.dts | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/zynq-zedboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..1d36a4c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -174,7 +174,8 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
 	wm8505-ref.dtb \
 	wm8650-mid.dtb \
 	wm8850-w70v2.dtb
-dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
+dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb \
+	zynq-zedboard.dtb
 
 targets += dtbs
 targets += $(dtb-y)
diff --git a/arch/arm/boot/dts/zynq-zedboard.dts b/arch/arm/boot/dts/zynq-zedboard.dts
new file mode 100644
index 0000000..1b024c7
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zedboard.dts
@@ -0,0 +1,45 @@
+/*
+ *  Copyright (C) 2013 Steffen Trumrar <s.trumtrar@pengutronix.de>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+/dts-v1/;
+/include/ "zynq-7000.dtsi"
+
+/ {
+	model = "Zynq ZedBoard";
+	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x20000000>;
+	};
+};
+
+&gem0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&ps_clk {
+	clock-frequency = <33333330>;
+};
+
+&ttc0_0 {
+	status = "okay";
+	compatible = "xlnx,ttc-counter-clockevent";
+};
-- 
1.8.2.rc2
