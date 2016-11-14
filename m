From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 14 Nov 2016 20:17:43 +0800
Subject: [PATCH v2 10/10] ARM: dts: rockchip: add rockchip RK1108 Evaluation
 board
In-Reply-To: <1479124550-24037-1-git-send-email-andy.yan@rock-chips.com>
References: <1479124550-24037-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1479125863-24646-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK1108 EVB is designed by Rockchip for CVR field.
This patch add basic support for it, which can boot with
initramfs into shell.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v2:
- move the board in the rockchip.txt to the block of Rockchip boards

 Documentation/devicetree/bindings/arm/rockchip.txt |  5 +-
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/rk1108-evb.dts                   | 69 ++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk1108-evb.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 10b92b5..e658b62 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -1,6 +1,5 @@
 Rockchip platforms device tree bindings
 ---------------------------------------
-
 - Kylin RK3036 board:
     Required root node properties:
       - compatible = "rockchip,kylin-rk3036", "rockchip,rk3036";
@@ -111,6 +110,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "rockchip,px5-evb", "rockchip,px5", "rockchip,rk3368";
 
+- Rockchip RK1108 Evaluation board
+    Required root node properties:
+      - compatible = "rockchip,rk1108-evb", "rockchip,rk1108";
+
 - Rockchip RK3368 evb:
     Required root node properties:
       - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e49476a..249dca9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -635,6 +635,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pba8.dtb \
 	arm-realview-pbx-a9.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
+	rk1108-evb.dtb \
 	rk3036-evb.dtb \
 	rk3036-kylin.dtb \
 	rk3066a-bqcurie2.dtb \
diff --git a/arch/arm/boot/dts/rk1108-evb.dts b/arch/arm/boot/dts/rk1108-evb.dts
new file mode 100644
index 0000000..3956cff
--- /dev/null
+++ b/arch/arm/boot/dts/rk1108-evb.dts
@@ -0,0 +1,69 @@
+/*
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
+ *  Or, alternatively,
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
+
+#include "rk1108.dtsi"
+
+/ {
+	model = "Rockchip RK1108 Evaluation board";
+	compatible = "rockchip,rk1108-evb", "rockchip,rk1108";
+
+	memory at 60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x08000000>;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.7.4
