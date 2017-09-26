From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:18 +0200
Subject: [PATCH v2 08/10] ARM: dts: add dtsi for AXP813 PMIC
In-Reply-To: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <d0d72d485596fa2b6bb0000c67132c97374798ce.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The AXP813 PMIC is used with some Allwinner SoCs. Create a dtsi to
include in each board embedding it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp813.dtsi | 58 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/axp813.dtsi

diff --git a/arch/arm/boot/dts/axp813.dtsi b/arch/arm/boot/dts/axp813.dtsi
new file mode 100644
index 0000000..e7f95e8
--- /dev/null
+++ b/arch/arm/boot/dts/axp813.dtsi
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2017 Free Electrons
+ *
+ * Quentin Schulz <quentin.schulz@free-electrons.com>
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
+ * AXP813 Integrated Power Management Chip
+ */
+
+&axp813 {
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	axp_pctl: axp_pctl {
+		compatible = "x-powers,axp813-pctl";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
git-series 0.9.1
