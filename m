From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  8 Sep 2016 23:46:49 +0200
Subject: [PATCH 4/4] ARM: dts: add RealView EB rev D A9 MPCore variant
In-Reply-To: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
References: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1473371209-24086-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex A9 MPCore tile can be mounted on top of the revision
D variant of the RealView EB, so create another variant of the
DTS file for this.

arm-realview-eb-a9mp = mounted on pre-revision D baseboard
arm-realview-eb-a9mp-bbrevd = mounted on the revision D baseboard

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts | 28 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2ec6f6236165..0f911bdc4282 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -614,6 +614,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-eb-11mp-ctrevb.dtb \
 	arm-realview-eb-11mp-bbrevd-ctrevb.dtb \
 	arm-realview-eb-a9mp.dtb \
+	arm-realview-eb-a9mp-bbrevd.dtb \
 	arm-realview-pba8.dtb \
 	arm-realview-pbx-a9.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
diff --git a/arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts b/arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts
new file mode 100644
index 000000000000..42efac7496ef
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "arm-realview-eb-a9mp.dts"
+#include "arm-realview-eb-bbrevd.dtsi"
+
+/ {
+	model = "ARM RealView EB Baseboard Rev D Cortex A9 MPCore";
+};
-- 
2.7.4
