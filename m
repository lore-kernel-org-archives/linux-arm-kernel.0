From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  2 Mar 2016 03:35:01 +0100
Subject: [PATCH v2 6/6] ARM64: dts: amlogic: Add Tronsmart Vega S95 configs
In-Reply-To: <1456886101-22967-1-git-send-email-afaerber@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
Message-ID: <1456886101-22967-7-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Trees for Tronsmart Vega S95 Pro, Meta and Telos TV boxes.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Dropped aliases (moved to Meson gxbb .dtsi)
 * Override only status of uart node (moved to Meson gxbb .dtsi)
 
 arch/arm64/boot/dts/amlogic/Makefile               |  4 ++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  | 55 ++++++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   | 55 ++++++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts | 55 ++++++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 55 ++++++++++++++++++++++
 5 files changed, 224 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 1b06c28c67eb..eb672f38f89e 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,3 +1,7 @@
+dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
+
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
new file mode 100644
index 000000000000..399aff9e7975
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2016 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
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
+
+#include "meson-gxbb-vega-s95.dtsi"
+
+/ {
+	compatible = "tronsmart,vega-s95-meta", "tronsmart,vega-s95", "amlogic,meson-gxbb";
+	model = "Tronsmart Vega S95 Meta";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
new file mode 100644
index 000000000000..ac5a241b5ec2
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2016 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
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
+
+#include "meson-gxbb-vega-s95.dtsi"
+
+/ {
+	compatible = "tronsmart,vega-s95-pro", "tronsmart,vega-s95", "amlogic,meson-gxbb";
+	model = "Tronsmart Vega S95 Pro";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
new file mode 100644
index 000000000000..fff7bfa2aa39
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2016 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
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
+
+#include "meson-gxbb-vega-s95.dtsi"
+
+/ {
+	compatible = "tronsmart,vega-s95-telos", "tronsmart,vega-s95", "amlogic,meson-gxbb";
+	model = "Tronsmart Vega S95 Telos";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
new file mode 100644
index 000000000000..c1fa2667ec5c
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2016 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
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
+#include "meson-gxbb.dtsi"
+
+/ {
+	compatible = "tronsmart,vega-s95", "amlogic,meson-gxbb";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
-- 
2.6.2
