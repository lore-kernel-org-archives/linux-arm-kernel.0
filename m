From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:55 +0200
Subject: [PATCH 14/15] ARM: dts: sun8i: Add dts file for Polaroid MID2407PXE03
 tablet
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-15-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Polaroid MID2407PXE03 is an a23 based 7" tablet based on a M86_MB V2.0
PCB, featuring a 800x480 LCD, 512MB RAM, 4G NAND, esp8089 wifi, gsl1680
touchschreen, micro-sd slot, 3.5mm headphone jack and a micro-usb otg
connector which doubles as charging port.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use sun8i-reference-design-tablet.dtsi
-Note this makes the dts pretty much empty for now, this will change
 once the touchscreen driver + some mmc-pwrseq changes for the sdio wifi
 land upstream
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   | 50 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e9fcd25..fca6811 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -755,6 +755,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-gt90h-v4.dtb \
 	sun8i-a23-ippo-q8h-v5.dtb \
 	sun8i-a23-ippo-q8h-v1.2.dtb \
+	sun8i-a23-polaroid-mid2407pxe03.dtb \
 	sun8i-a23-polaroid-mid2809pxe04.dtb \
 	sun8i-a23-q8-tablet.dtb \
 	sun8i-a33-et-q8-v1.6.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
new file mode 100644
index 0000000..e300442
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2016 Hans de Goede <hdegoede@redhat.com>
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
+#include "sun8i-reference-design-tablet.dtsi"
+
+/ {
+	model = "Polaroid MID2407PXE03 tablet";
+	compatible = "polaroid,mid2407pxe03", "allwinner,sun8i-a23";
+};
-- 
2.7.4
