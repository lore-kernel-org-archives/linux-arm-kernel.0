From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun,  5 Oct 2014 23:59:14 +0200
Subject: [PATCH v2 2/7] ARM: dts: add dtsi for Amlogic Meson8 SoCs
In-Reply-To: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
References: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1412546359-15062-3-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a dtsi for Amlogic Meson8 SoCs. It differs from the Meson6
dtsi for the number of Cortex-A9 cores (4 vs 2) and for the frequency
of clk81.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 88 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson8.dtsi

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
new file mode 100644
index 0000000..42e4026
--- /dev/null
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -0,0 +1,88 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
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
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program. If not, see <http://www.gnu.org/licenses/>.
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
+/include/ "meson.dtsi"
+
+/ {
+	model = "Amlogic Meson8 SoC";
+	compatible = "amlogic,meson8";
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x200>;
+		};
+
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x201>;
+		};
+
+		cpu at 202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x202>;
+		};
+
+		cpu at 203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x203>;
+		};
+	};
+
+	clk81: clk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <141666666>;
+	};
+}; /* end of / */
-- 
1.9.1
