From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Fri, 23 Oct 2015 07:46:17 +0800
Subject: [PATCH v2 3/3] ARM: dts: sun8i: Add A83T HomletV2 Board by Allwinner
In-Reply-To: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1445557577-27383-4-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H8Homlet Proto v2.0 Board is A83T Dev Board by Allwinner.
It has UART, ethernet, USB, HDMI, etc ports on it.

A83T patches are tested on this board.
It has UART, ethernet, USB, HDMI, etc ports on it.

For FEL mode it needs USB A-A(Male) cable. I used uart0 which
is multiplexed to microsd pins PF2 and PF4.

Enabled UART0 Header(PB9, PB10 pins).

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts

diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
new file mode 100644
index 0000000..342e1d3
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2015 Vishnu Patekar
+ * Vishnu Patekar <vishnupatekar0510@gmail.com>
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
+#include "sun8i-a83t.dtsi"
+
+/ {
+	model = "Allwinner A83T H8Homlet Proto Dev Board v2.0";
+	compatible = "allwinner,h8homlet-v2", "allwinner,sun8i-a83t";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_b>;
+	status = "okay";
+};
-- 
1.9.1
