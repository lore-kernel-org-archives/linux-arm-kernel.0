From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  3 Sep 2016 13:05:18 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: Add dts file for the Orange Pi Plus2E SBC
In-Reply-To: <20160903110518.8267-1-hdegoede@redhat.com>
References: <20160903110518.8267-1-hdegoede@redhat.com>
Message-ID: <20160903110518.8267-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Plus2E is an extended version of the Orange Pi Pc Plus,
with 2G RAM and an external gbit ethernet phy.

Note currently the dts is pretty much empty (except for including the
pc-plus dts), I've a local patch which enables the emac actually making
this dts different from the pc-plus one, but that needs the h3 emac
driver to get merged first.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                     |  1 +
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts | 53 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7dd4a07..bb906f2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -798,6 +798,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-pc.dtb \
 	sun8i-h3-orangepi-pc-plus.dtb \
 	sun8i-h3-orangepi-plus.dtb \
+	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-r16-parrot.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
new file mode 100644
index 0000000..5851a47
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com>
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
+/*
+ * The Orange Pi Plus 2E is an extended version of the Orange Pi PC Plus,
+ * with 2G RAM and an external gbit ethernet phy.
+ */
+
+#include "sun8i-h3-orangepi-pc-plus.dts"
+
+/ {
+	model = "Xunlong Orange Pi Plus 2E";
+	compatible = "xunlong,orangepi-plus2e", "allwinner,sun8i-h3";
+};
-- 
2.9.3
