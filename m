From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 13 Oct 2015 14:35:47 +0200
Subject: [PATCH 2/3] ARM: dts: sun8i: Make ippo-q8h-v*.dts a symlink to
 q8-tablet.dts
In-Reply-To: <1444739748-26422-1-git-send-email-hdegoede@redhat.com>
References: <1444739748-26422-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1444739748-26422-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A23 Q8 tablets with the ippo-q8h-v* pcb will work fine with the
generic q8-tablet.dts and given the many variants of PCBs found in
Q8 tablets using such a specific dts name was a mistake in hindsight.

We cannot just drop the ippo-q8h-v*.dtb as existing u-boot configs
may very well point to it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
The plan is to remove the matching u-boot config after v2015.10 (which will
ship with a generic q8_a23_tablet_defconfig file), and then once the
next u-boot has shipped for a bit we can consider removing the symlink
and Makefile entry for these.
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts | 55 +-------------------
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts   | 75 +--------------------------
 2 files changed, 2 insertions(+), 128 deletions(-)
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
deleted file mode 100644
index 382d64c..0000000
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/*
- * The Ippo Q8H v1.2 is almost identical to the v5, still it needs a separate
- * dtb file since some gpio-s surrounding the wlan/bluetooth are different,
- * and it uses different camera sensors.
- */
-
-#include "sun8i-a23-ippo-q8h-v5.dts"
-
-/ {
-	model = "Ippo Q8H Dual Core Tablet (v1.2)";
-	compatible = "ippo,q8h-v1.2", "allwinner,sun8i-a23";
-};
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
new file mode 120000
index 0000000..c2f22fc
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
@@ -0,0 +1 @@
+sun8i-a23-q8-tablet.dts
\ No newline at end of file
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
deleted file mode 100644
index 4f47fd6..0000000
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Copyright 2014 Chen-Yu Tsai
- *
- * Chen-Yu Tsai <wens@csie.org>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/dts-v1/;
-#include "sun8i-a23.dtsi"
-#include "sun8i-q8-common.dtsi"
-
-/ {
-	model = "Ippo Q8H Dual Core Tablet (v5)";
-	compatible = "ippo,q8h-v5", "allwinner,sun8i-a23";
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
-	/* pull-ups and devices require PMIC regulator */
-	status = "failed";
-};
-
-/*
- * FIXME for now we only support host mode and rely on u-boot to have
- * turned on Vbus which is controlled by the axp223 pmic on the board.
- *
- * Once we have axp223 support we should switch to fully supporting otg.
- */
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
new file mode 120000
index 0000000..c2f22fc
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -0,0 +1 @@
+sun8i-a23-q8-tablet.dts
\ No newline at end of file
-- 
2.5.0
