From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 13 Oct 2017 12:43:03 +0200
Subject: [PATCH 7/7] ARM: dts: imx6ul-txul: add support for TXUL modules on
 MB7 baseboard
In-Reply-To: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507891383-15452-8-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dtsi file for TXUL modules on the MB7 baseboard and use it to
create dts files for the various TXUL module variants on the MB7
baseboard.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile                  |  5 +-
 arch/arm/boot/dts/imx6ul-txul-5010-mb7.dts  | 48 +++++++++++++++++++
 arch/arm/boot/dts/imx6ul-txul-5011-mb7.dts  | 48 +++++++++++++++++++
 arch/arm/boot/dts/imx6ul-txul-mb7.dtsi      | 74 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ull-txul-8013-mb7.dts | 48 +++++++++++++++++++
 5 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-txul-5010-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-txul-5011-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-txul-mb7.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-txul-8013-mb7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f61cee7..b7fc301 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -475,10 +475,13 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-txul-5010-mainboard.dtb \
+	imx6ul-txul-5010-mb7.dtb \
 	imx6ul-txul-5011-mainboard.dtb \
+	imx6ul-txul-5011-mb7.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-txul-8013.dtb \
-	imx6ull-txul-8013-mainboard.dtb
+	imx6ull-txul-8013-mainboard.dtb \
+	imx6ull-txul-8013-mb7.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-txul-5010-mb7.dts b/arch/arm/boot/dts/imx6ul-txul-5010-mb7.dts
new file mode 100644
index 0000000..73c5e8f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-txul-5010-mb7.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6ul-tx6ul-0010.dts"
+#include "imx6ul-txul-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TXUL-5010/-0010 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6ul-txul-5011-mb7.dts b/arch/arm/boot/dts/imx6ul-txul-5011-mb7.dts
new file mode 100644
index 0000000..cf325f1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-txul-5011-mb7.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6ul-tx6ul-0011.dts"
+#include "imx6ul-txul-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TXUL-5011/-0011 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6ul-txul-mb7.dtsi b/arch/arm/boot/dts/imx6ul-txul-mb7.dtsi
new file mode 100644
index 0000000..7771c6b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-txul-mb7.dtsi
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/ {
+	lcd-panel {
+		compatible = "edt,et057090dhu";
+		bus-format-override = "rgb24";
+		pixelclk-active = <0>;
+	};
+
+	/delete-node/ sound;
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&can2 {
+	xceiver-supply = <&reg_3v3>;
+};
+
+&i2c2 {
+	rtc: mcp7940x at 6f {
+		compatible = "microchip,mcp7940x";
+		reg = <0x6f>;
+	};
+};
+
+&sgtl5000 {
+	/*
+	 * The SGTL5000 present on the MB7 baseboard cannot be used
+	 * because the JTAG interface shares the SAI interface pins.
+	 * Especially JTAG_TDI drives the SAI BITCLK via a level shifter.
+	 */
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6ull-txul-8013-mb7.dts b/arch/arm/boot/dts/imx6ull-txul-8013-mb7.dts
new file mode 100644
index 0000000..0f16809
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-txul-8013-mb7.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6ull-txul-8013.dts"
+#include "imx6ul-txul-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TXUL-8013 Module on MB7 baseboard";
+};
-- 
2.1.4
