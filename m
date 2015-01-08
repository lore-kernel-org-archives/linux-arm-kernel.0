From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 11:51:44 +0100
Subject: [PATCH v2 7/8] ARM: mvebu: Add Device Tree description of the Armada
 388 SoC
In-Reply-To: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1420714305-7496-8-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SoC belongs to the Armada 38x family. The main difference with
the Armada 385 is that the 388 can handle two more SATA
ports. Currently the only consequence is the use of a different
compatible string for the pinctrl node, in order to be able to use the
pins associated to this 2 new SATA ports.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-388.dtsi | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-388.dtsi

diff --git a/arch/arm/boot/dts/armada-388.dtsi b/arch/arm/boot/dts/armada-388.dtsi
new file mode 100644
index 000000000000..c762ff7ed1d1
--- /dev/null
+++ b/arch/arm/boot/dts/armada-388.dtsi
@@ -0,0 +1,58 @@
+/*
+ * Device Tree Include file for Marvell Armada 388 SoC.
+ *
+ * Copyright (C) 2015 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is licensed under the terms of the GNU General Public
+ *     License version 2.  This program is licensed "as is" without
+ *     any warranty of any kind, whether express or implied.
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
+ *
+ *
+ * The main difference with the Armada 385 is that the 388 can handle two more
+ * SATA ports. So we can reuse the dtsi of the Armada 385 and just override
+ * the pinctrl property and the name of the SoC.
+ */
+
+#include "armada-385.dtsi"
+
+/ {
+	model = "Marvell Armada 388 family SoC";
+	compatible = "marvell,armada388", "marvell,armada380";
+	soc {
+		internal-regs {
+			pinctrl at 18000 {
+				compatible = "marvell,mv88f6828-pinctrl";
+			};
+		};
+	};
+};
-- 
1.9.1
