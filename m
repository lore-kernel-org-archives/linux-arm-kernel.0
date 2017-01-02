From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 14:59:22 +0000
Subject: [PATCH 9/9] ARM: dts: armada388-clearfog: add pro model DTS file
In-Reply-To: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
References: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO454-00083C-Tj@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DTS file to describe the clearfog pro model - we update the
platform name and compatible string compared to the original version.
The original version remains for compatibility for the time being as
the name of the file has become established, and the machine name
and/or compatible may be used by userspace.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/armada-388-clearfog-pro.dts | 55 +++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog-pro.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 22d2ca2b52ec..8cf288f8b84f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -922,6 +922,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-linksys-cobra.dtb \
 	armada-388-clearfog.dtb \
 	armada-388-clearfog-base.dtb \
+	armada-388-clearfog-pro.dtb \
 	armada-388-db.dtb \
 	armada-388-gp.dtb \
 	armada-388-rd.dtb
diff --git a/arch/arm/boot/dts/armada-388-clearfog-pro.dts b/arch/arm/boot/dts/armada-388-clearfog-pro.dts
new file mode 100644
index 000000000000..e0c630a4d92c
--- /dev/null
+++ b/arch/arm/boot/dts/armada-388-clearfog-pro.dts
@@ -0,0 +1,55 @@
+/*
+ * Device Tree file for SolidRun Clearfog Pro revision A1 rev 2.0 (88F6828)
+ *
+ *  Copyright (C) 2015 Russell King
+ *
+ * This board is in development; the contents of this file work with
+ * the A1 rev 2.0 of the board, which does not represent final
+ * production board.  Things will change, don't expect this file to
+ * remain compatible info the future.
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
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include "armada-388-clearfog.dts"
+
+/ {
+	model = "SolidRun Clearfog Pro A1";
+	compatible = "solidrun,clearfog-pro-a1",
+		"solidrun,clearfog-a1", "marvell,armada388",
+		"marvell,armada385", "marvell,armada380";
+};
-- 
2.7.4
