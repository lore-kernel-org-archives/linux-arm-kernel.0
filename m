From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 24 Sep 2015 17:23:54 +0200
Subject: [PATCH 3/3] ARM: dts: sun8i: Make ippo-q8h-v1.2.dts a symlink to
 q8-tablet.dts
In-Reply-To: <1443108234-14837-1-git-send-email-hdegoede@redhat.com>
References: <1443108234-14837-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1443108234-14837-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A33 Q8 tablets with the ippo-q8h-v1.2 pcb will work fine with the
generic q8-tablet.dts and given the many variants of PCBs found in
Q8 tablets using such a specific dts name was a mistake in hindsight.

We cannot just drop the ippo-q8h-v1.2.dtb as existing u-boot configs
may very well point to it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
The plan is to remove the matching u-boot config after v2015.10 (which will
ship with a generic q8_a33_tablet_defconfig file), and then once the
next u-boot has shipped for a bit we can consider removing the symlink
and Makefile entry for this.
---
 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts | 66 +--------------------------
 1 file changed, 1 insertion(+), 65 deletions(-)
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts

diff --git a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
deleted file mode 100644
index b8439cb..0000000
--- a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
+++ /dev/null
@@ -1,65 +0,0 @@
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
-/dts-v1/;
-#include "sun8i-a33.dtsi"
-#include "sun8i-q8-common.dtsi"
-
-/ {
-	model = "Ippo Q8H Quad Core Tablet (v1.2)";
-	compatible = "ippo,a33-q8h-v1.2", "allwinner,sun8i-a33";
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
diff --git a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
new file mode 120000
index 0000000..4519fd7
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
@@ -0,0 +1 @@
+sun8i-a33-q8-tablet.dts
\ No newline at end of file
-- 
2.5.0
