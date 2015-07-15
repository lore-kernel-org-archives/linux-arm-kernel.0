From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 15 Jul 2015 13:30:43 +0200
Subject: [PATCH v1.1 1/4] ARM: dts: Add sbs-battery dts fragment used by
 chromebooks
In-Reply-To: <1436574562-16308-2-git-send-email-heiko@sntech.de>
References: <1436574562-16308-1-git-send-email-heiko@sntech.de>
 <1436574562-16308-2-git-send-email-heiko@sntech.de>
Message-ID: <1731785.1QCGhpnXSY@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates a sbs-battery fragment for batteries connected
to the i2c tunnel of the cros-ec embedded controller.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v1:
- correct license

 arch/arm/boot/dts/cros-ec-sbs.dtsi | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 arch/arm/boot/dts/cros-ec-sbs.dtsi

diff --git a/arch/arm/boot/dts/cros-ec-sbs.dtsi b/arch/arm/boot/dts/cros-ec-sbs.dtsi
new file mode 100644
index 0000000..71f5c5e
--- /dev/null
+++ b/arch/arm/boot/dts/cros-ec-sbs.dtsi
@@ -0,0 +1,52 @@
+/*
+ * Smart battery dts fragment for devices that use cros-ec-sbs
+ *
+ * Copyright (c) 2015 Google, Inc
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
+&i2c_tunnel {
+	battery: sbs-battery at b {
+		compatible = "sbs,sbs-battery";
+		reg = <0xb>;
+		sbs,i2c-retry-count = <2>;
+		sbs,poll-retry-count = <1>;
+	};
+};
-- 
2.1.4
