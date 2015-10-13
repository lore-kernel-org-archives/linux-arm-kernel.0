From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 13 Oct 2015 14:35:48 +0200
Subject: [PATCH 3/3] ARM: dts: sun8i: Make et-q8-v1.6.dts a symlink to
 q8-tablet.dts
In-Reply-To: <1444739748-26422-1-git-send-email-hdegoede@redhat.com>
References: <1444739748-26422-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1444739748-26422-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A33 Q8 tablets with the et-q8-v1.6 pcb will work fine with the
generic q8-tablet.dts and given the many variants of PCBs found in
Q8 tablets using such a specific dts name was a mistake in hindsight.

We cannot just drop the et-q8-v1.6.dtb as existing u-boot configs
may very well point to it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts | 89 +-----------------------------
 1 file changed, 1 insertion(+), 88 deletions(-)
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts

diff --git a/arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts b/arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
deleted file mode 100644
index 19db844..0000000
--- a/arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * Copyright 2015 Vishnu Patekar
- * Vishnu Patekar <vishnupatekar0510@gmail.com>
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
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
-
-/ {
-	model = "ET Q8 Quad Core Tablet (v1.6)";
-	compatible = "et,q8-v1.6", "allwinner,sun8i-a33";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_vcc3v0>;
-	status = "okay";
-
-	button at 200 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button at 400 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts b/arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
new file mode 120000
index 0000000..4519fd7
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
@@ -0,0 +1 @@
+sun8i-a33-q8-tablet.dts
\ No newline at end of file
-- 
2.5.0
