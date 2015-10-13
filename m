From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 13 Oct 2015 14:35:46 +0200
Subject: [PATCH 1/3] ARM: dts: sun8i: Add sun8i-a23-q8-tablet.dts file
Message-ID: <1444739748-26422-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a generic dts file for A23 based q8 formfactor tablets,
this is intended to replace both sun8i-a23-ippo-q8h-v5.dts and
sun8i-a23-ippo-q8h-v1.2.dts (these can be fully dropped after a
transition period).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts | 65 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e76fe3a..71f9655 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -636,6 +636,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-gt90h-v4.dtb \
 	sun8i-a23-ippo-q8h-v5.dtb \
 	sun8i-a23-ippo-q8h-v1.2.dtb \
+	sun8i-a23-q8-tablet.dtb \
 	sun8i-a33-et-q8-v1.6.dtb \
 	sun8i-a33-ga10h-v1.1.dtb \
 	sun8i-a33-ippo-q8h-v1.2.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
new file mode 100644
index 0000000..6062ea7
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
@@ -0,0 +1,65 @@
+/*
+ * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
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
+#include "sun8i-a23.dtsi"
+#include "sun8i-q8-common.dtsi"
+
+/ {
+	model = "Q8 A23 Tablet";
+	compatible = "allwinner,q8-a23", "allwinner,sun8i-a23";
+};
+
+/*
+ * FIXME for now we only support host mode and rely on u-boot to have
+ * turned on Vbus which is controlled by the axp223 pmic on the board.
+ *
+ * Once we have axp223 support we should switch to fully supporting otg.
+ */
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.5.0
