From: cl@rock-chips.com (cl at rock-chips.com)
Date: Mon, 27 Mar 2017 17:40:49 +0800
Subject: [PATCH v4 5/6] arm64: dts: rockchip: add dts file for RK3328
In-Reply-To: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Message-ID: <1490607650-18650-5-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

This patch add rk3328-evb.dts for RK3328 evaluation board.
Tested on RK3328 evb.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/Makefile       |  1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 57 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 3a86289..d09ea3c 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
new file mode 100644
index 0000000..cf27239
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -0,0 +1,57 @@
+/*
+ * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
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
+#include "rk3328.dtsi"
+
+/ {
+	model = "Rockchip RK3328 EVB";
+	compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
1.9.1
