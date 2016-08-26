From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Aug 2016 16:42:25 +0200
Subject: [PATCH 3/4] ARM: dts: sun5i: Add dts file for the Empire Electronix
 M712 tablet
In-Reply-To: <20160826144226.29969-1-hdegoede@redhat.com>
References: <20160826144226.29969-1-hdegoede@redhat.com>
Message-ID: <20160826144226.29969-3-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dts file for the Empire Electronix M712 tablet, this is a 7" A13
tablet, with micro-usb (otg), headphone and micro-sd slots on the
outside. It uses a Goodix gt811 touchscreen controller, a RTL8188CTV
wifi chip and a DMART06 (1238a4) accelerometer.

Note currently the dts for this is somewhat empty. This will change
once we add support for the touchscreen and accelerometer.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/sun5i-a13-empire-electronix-m712.dts  | 51 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1ec7fe9..94d5591 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -727,6 +727,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a10s-wobo-i5.dtb \
 	sun5i-a13-difrnce-dit4350.dtb \
 	sun5i-a13-empire-electronix-d709.dtb \
+	sun5i-a13-empire-electronix-m712.dtb \
 	sun5i-a13-hsg-h702.dtb \
 	sun5i-a13-inet-98v-rev2.dtb \
 	sun5i-a13-olinuxino.dtb \
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts
new file mode 100644
index 0000000..b1e2afd
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts
@@ -0,0 +1,51 @@
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
+#include "sun5i-a13.dtsi"
+#include "sun5i-reference-design-tablet.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Empire Electronix M712 tablet";
+	compatible = "empire-electronix,m712", "allwinner,sun5i-a13";
+};
-- 
2.9.3
