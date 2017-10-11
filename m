From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:50:35 +0200
Subject: [PATCH 12/12] ARM: dts: imx: add support for TX6 modules on MB7
 baseboard
In-Reply-To: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
References: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507722635-30801-13-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create .dts files for various Ka-Ro electronics TX modules on the MB7
basseboard.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile                  |  8 ++++
 arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts  | 48 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts  | 48 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts  | 48 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts  | 48 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts  | 17 +--------
 arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts   | 48 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts   | 48 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts | 48 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts | 57 +++++++++++++++++++++++++++++
 10 files changed, 403 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0672369..f4e3507 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -383,9 +383,13 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-ts4900.dtb \
 	imx6dl-tx6dl-comtft.dtb \
 	imx6dl-tx6s-8034.dtb \
+	imx6dl-tx6s-8034-mb7.dtb \
 	imx6dl-tx6s-8035.dtb \
+	imx6dl-tx6s-8035-mb7.dtb \
 	imx6dl-tx6u-801x.dtb \
+	imx6dl-tx6u-80xx-mb7.dtb \
 	imx6dl-tx6u-8033.dtb \
+	imx6dl-tx6u-8033-mb7.dtb \
 	imx6dl-tx6u-811x.dtb \
 	imx6dl-tx6u-81xx-mb7.dtb \
 	imx6dl-udoo.dtb \
@@ -440,6 +444,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-tx6q-1020.dtb \
 	imx6q-tx6q-1020-comtft.dtb \
 	imx6q-tx6q-1036.dtb \
+	imx6q-tx6q-1036-mb7.dtb \
+	imx6q-tx6q-10x0-mb7.dtb \
 	imx6q-tx6q-1110.dtb \
 	imx6q-tx6q-11x0-mb7.dtb \
 	imx6q-udoo.dtb \
@@ -452,7 +458,9 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6qp-sabreauto.dtb \
 	imx6qp-sabresd.dtb \
 	imx6qp-tx6qp-8037.dtb \
+	imx6qp-tx6qp-8037-mb7.dtb \
 	imx6qp-tx6qp-8137.dtb \
+	imx6qp-tx6qp-8137-mb7.dtb \
 	imx6qp-zii-rdu2.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts
new file mode 100644
index 0000000..fc23b4d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts
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
+#include "imx6dl-tx6s-8034.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6S-8034 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts
new file mode 100644
index 0000000..4101c65
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts
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
+#include "imx6dl-tx6s-8035.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6U-8035 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts
new file mode 100644
index 0000000..d34189f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts
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
+#include "imx6dl-tx6u-8033.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6U-8033 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts
new file mode 100644
index 0000000..aef5fcc
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts
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
+#include "imx6dl-tx6u-801x.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6U-8030/-8010/-8012 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
index 21eaec9..c4588fb 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
@@ -40,22 +40,9 @@
  */
 
 /dts-v1/;
-#include "imx6dl.dtsi"
-#include "imx6qdl-tx6.dtsi"
-#include "imx6qdl-tx6-lvds.dtsi"
+#include "imx6dl-tx6u-811x.dts"
 #include "imx6qdl-tx6-mb7.dtsi"
 
 / {
-	model = "Ka-Ro electronics TX6U-81xx Module on MB7 baseboard";
-	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
-};
-
-&backlight0 {
-	pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-	turn-on-delay-ms = <35>;
-};
-
-&backlight1 {
-	pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
-	turn-on-delay-ms = <35>;
+	model = "Ka-Ro electronics TX6U-8130/-8110 Module on MB7 baseboard";
 };
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts b/arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts
new file mode 100644
index 0000000..9ffbb0fe7
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts
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
+#include "imx6q-tx6q-1036.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q-1036 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts b/arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts
new file mode 100644
index 0000000..d43a5d8
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts
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
+#include "imx6q-tx6q-1010.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q-1010/-1030 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts b/arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts
new file mode 100644
index 0000000..92b38e6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts
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
+#include "imx6qp-tx6qp-8037.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q-8037 Module on MB7 baseboard";
+};
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts b/arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts
new file mode 100644
index 0000000..07ad707
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts
@@ -0,0 +1,57 @@
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
+#include "imx6qp-tx6qp-8137.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q-8137 Module on MB7 baseboard";
+	compatible = "karo,imx6qp-tx6qp", "fsl,imx6qp";
+};
+
+&ipu2 {
+	status = "disabled";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.1.4
