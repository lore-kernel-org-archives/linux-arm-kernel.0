From: denis@eukrea.com (Denis Carikli)
Date: Wed, 22 Jan 2014 14:48:30 +0100
Subject: [PATCHv6 6/7] ARM: dts: mbimx51sd: Add display support.
In-Reply-To: <1390398511-8041-1-git-send-email-denis@eukrea.com>
References: <1390398511-8041-1-git-send-email-denis@eukrea.com>
Message-ID: <1390398511-8041-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CMO-QVGA, DVI-SVGA and DVI-VGA are added.

Cc: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- Reordered the Cc list.

ChangeLog v3->v5:
- Updated to new GPIO defines.
- Updated to new licenses checkpatch requirements.
- one whitespace cleanup.

ChangeLog v2->v3:
- Splitted out from the patch that added support for the cpuimx51/mbimxsd51 boards.
- This patch now only adds display support.
- Added some interested people in the Cc list, and removed some people that
  might be annoyed by the receiving of that patch which is unrelated to their
  subsystem.
- rebased and reworked the dts displays addition.
- Also rebased and reworked the fsl,pins usage.
---
 .../imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts  |   55 ++++++++++++++++++++
 .../imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts  |   42 +++++++++++++++
 .../imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts   |   42 +++++++++++++++
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   13 +++++
 4 files changed, 152 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..f37d65b
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx51-eukrea-mbimxsd51-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD51 with the CMO-QVGA Display";
+	compatible = "eukrea,mbimxsd51-baseboard-cmo-qvga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
+
+	reg_lcd_3v3: lcd-en {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&display {
+	display-supply = <&reg_lcd_3v3>;
+	status = "okay";
+	display-timings {
+		model = "CMO-QVGA";
+		bits-per-pixel = <16>;
+		cmoqvga {
+			native-mode;
+			clock-frequency = <6500000>;
+			hactive = <320>;
+			vactive = <240>;
+			hfront-porch = <20>;
+			hback-porch = <38>;
+			vfront-porch = <4>;
+			vback-porch = <15>;
+			hsync-len = <30>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <0>;
+			pixelclk-active = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts
new file mode 100644
index 0000000..07e80e8
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx51-eukrea-mbimxsd51-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD51 with the DVI-SVGA Display";
+	compatible = "eukrea,mbimxsd51-baseboard-dvi-svga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
+};
+
+&display {
+	status = "okay";
+	display-timings {
+		model = "DVI-SVGA";
+		bits-per-pixel = <16>;
+		svga {
+			clock-frequency = <38251000>;
+			hactive = <800>;
+			vactive = <600>;
+			hback-porch = <112>;
+			hfront-porch = <32>;
+			vback-porch = <3>;
+			vfront-porch = <17>;
+			hsync-len = <80>;
+			vsync-len = <4>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+			de-active = <1>;
+			pixelclk-active = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts
new file mode 100644
index 0000000..0ec523f
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx51-eukrea-mbimxsd51-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD51 with the DVI-VGA Display";
+	compatible = "eukrea,mbimxsd51-baseboard-dvi-vga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
+};
+
+&display {
+	status = "okay";
+	display-timings {
+		model = "DVI-VGA";
+		bits-per-pixel = <16>;
+		vga {
+			clock-frequency = <23750000>;
+			hactive = <640>;
+			vactive = <480>;
+			hback-porch = <80>;
+			hfront-porch = <16>;
+			vback-porch = <3>;
+			vfront-porch = <13>;
+			hsync-len = <64>;
+			vsync-len = <4>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+			de-active = <1>;
+			pixelclk-active = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 6774c66..06f987e 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -23,6 +23,15 @@
 	model = "Eukrea CPUIMX51";
 	compatible = "eukrea,mbimxsd51","eukrea,cpuimx51", "fsl,imx51";
 
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		crtcs = <&ipu 0>;
+		interface-pix-fmt = "rgb666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu_disp1>;
+		status = "disabled";
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -124,6 +133,10 @@
 			>;
 		};
 
+		pinctrl_ipu_disp1: ipudisp1grp {
+			fsl,pins = <MX51_IPU_DISP1_PINGRP1>;
+		};
+
 		pinctrl_reg_lcd_3v3: reg_lcd_3v3 {
 			fsl,pins = <
 				MX51_PAD_CSI1_D9__GPIO3_13 0x1f5
-- 
1.7.9.5
