From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 31 Dec 2014 13:06:18 +0530
Subject: [RFC PATCH v3 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <1420011379-7116-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1420011379-7116-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <1420011379-7116-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adding dt file for Cavium's Thunder SoC in 2 Node topology
using arm,associativity device node property.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
---
 arch/arm64/boot/dts/thunder-88xx-2n.dts  |  78 +++
 arch/arm64/boot/dts/thunder-88xx-2n.dtsi | 789 +++++++++++++++++++++++++++++++
 2 files changed, 867 insertions(+)
 create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dts
 create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dtsi

diff --git a/arch/arm64/boot/dts/thunder-88xx-2n.dts b/arch/arm64/boot/dts/thunder-88xx-2n.dts
new file mode 100644
index 0000000..5dc89d5e
--- /dev/null
+++ b/arch/arm64/boot/dts/thunder-88xx-2n.dts
@@ -0,0 +1,78 @@
+/*
+ * Cavium Thunder DTS file - Thunder board description
+ *
+ * Copyright (C) 2014, Cavium Inc.
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+
+/include/ "thunder-88xx-2n.dtsi"
+
+/ {
+	model = "Cavium ThunderX CN88XX board";
+	compatible = "cavium,thunder-88xx";
+	arm,associativity-reference-points = <0 1>;
+
+	aliases {
+		serial0 = &uaa0;
+		serial1 = &uaa1;
+	};
+
+	memory at 00000000 {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x0 0x80000000>;
+		/* board 0, socket 0, no specific core */
+		arm,associativity = <0 0 0xffff>;
+	};
+
+	memory at 10000000000 {
+		device_type = "memory";
+		reg = <0x100 0x00000000 0x0 0x80000000>;
+		/* board 1, socket 0, no specific core */
+		arm,associativity = <1 0 0xffff>;
+	};
+
+};
diff --git a/arch/arm64/boot/dts/thunder-88xx-2n.dtsi b/arch/arm64/boot/dts/thunder-88xx-2n.dtsi
new file mode 100644
index 0000000..f7f561a
--- /dev/null
+++ b/arch/arm64/boot/dts/thunder-88xx-2n.dtsi
@@ -0,0 +1,789 @@
+/*
+ * Cavium Thunder DTS file - Thunder SoC description
+ *
+ * Copyright (C) 2014, Cavium Inc.
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/ {
+	compatible = "cavium,thunder-88xx";
+	interrupt-parent = <&gic0>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 000 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "psci";
+			/* board 0, socket 0, core 0*/
+			arm,associativity = <0 0 0x000>;
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x001>;
+		};
+		cpu at 002 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x002>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x002>;
+		};
+		cpu at 003 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x003>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x003>;
+		};
+		cpu at 004 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x004>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x004>;
+		};
+		cpu at 005 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x005>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x005>;
+		};
+		cpu at 006 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x006>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x006>;
+		};
+		cpu at 007 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x007>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x007>;
+		};
+		cpu at 008 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x008>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x008>;
+		};
+		cpu at 009 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x009>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x009>;
+		};
+		cpu at 00a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00a>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x00a>;
+		};
+		cpu at 00b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00b>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x00b>;
+		};
+		cpu at 00c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00c>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x00c>;
+		};
+		cpu at 00d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00d>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x00d>;
+		};
+		cpu at 00e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00e>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x00e>;
+		};
+		cpu at 00f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00f>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x00f>;
+		};
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x100>;
+		};
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x101>;
+		};
+		cpu at 102 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x102>;
+		};
+		cpu at 103 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x103>;
+		};
+		cpu at 104 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x104>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x104>;
+		};
+		cpu at 105 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x105>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x105>;
+		};
+		cpu at 106 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x106>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x106>;
+		};
+		cpu at 107 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x107>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x107>;
+		};
+		cpu at 108 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x108>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x108>;
+		};
+		cpu at 109 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x109>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x109>;
+		};
+		cpu at 10a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10a>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x10a>;
+		};
+		cpu at 10b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10b>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x10b>;
+		};
+		cpu at 10c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10c>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x10c>;
+		};
+		cpu at 10d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10d>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x10d>;
+		};
+		cpu at 10e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10e>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x10e>;
+		};
+		cpu at 10f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10f>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x10f>;
+		};
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x200>;
+		};
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x201>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x201>;
+		};
+		cpu at 202 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x202>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x202>;
+		};
+		cpu at 203 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x203>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x203>;
+		};
+		cpu at 204 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x204>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x204>;
+		};
+		cpu at 205 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x205>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x205>;
+		};
+		cpu at 206 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x206>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x206>;
+		};
+		cpu at 207 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x207>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x207>;
+		};
+		cpu at 208 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x208>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x208>;
+		};
+		cpu at 209 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x209>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x209>;
+		};
+		cpu at 20a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20a>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x20a>;
+		};
+		cpu at 20b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20b>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x20b>;
+		};
+		cpu at 20c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20c>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x20c>;
+		};
+		cpu at 20d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20d>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x20d>;
+		};
+		cpu at 20e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20e>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x20e>;
+		};
+		cpu at 20f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20f>;
+			enable-method = "psci";
+			arm,associativity = <0 0 0x20f>;
+		};
+		cpu at 10000 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10000>;
+			enable-method = "psci";
+			/* board 1, socket 0, core 0*/
+			arm,associativity = <1 0 0x10000>;
+		};
+		cpu at 10001 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10001>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10001>;
+		};
+		cpu at 10002 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10002>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10002>;
+		};
+		cpu at 10003 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10003>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10003>;
+		};
+		cpu at 10004 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10004>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10004>;
+		};
+		cpu at 10005 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10005>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10005>;
+		};
+		cpu at 10006 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10006>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10006>;
+		};
+		cpu at 10007 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10007>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10007>;
+		};
+		cpu at 10008 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10008>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10008>;
+		};
+		cpu at 10009 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10009>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10009>;
+		};
+		cpu at 1000a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1000a>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1000a>;
+		};
+		cpu at 1000b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1000b>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1000b>;
+		};
+		cpu at 1000c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1000c>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1000c>;
+		};
+		cpu at 1000d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1000d>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1000d>;
+		};
+		cpu at 1000e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1000e>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1000e>;
+		};
+		cpu at 1000f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1000f>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1000f>;
+		};
+		cpu at 10100 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10100>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10100>;
+		};
+		cpu at 10101 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10101>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10101>;
+		};
+		cpu at 10102 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10102>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10102>;
+		};
+		cpu at 10103 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10103>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10103>;
+		};
+		cpu at 10104 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10104>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10104>;
+		};
+		cpu at 10105 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10105>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10105>;
+		};
+		cpu at 10106 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10106>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10106>;
+		};
+		cpu at 10107 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10107>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10107>;
+		};
+		cpu at 10108 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10108>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10108>;
+		};
+		cpu at 10109 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10109>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10109>;
+		};
+		cpu at 1010a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1010a>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1010a>;
+		};
+		cpu at 1010b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1010b>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1010b>;
+		};
+		cpu at 1010c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1010c>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1010c>;
+		};
+		cpu at 1010d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1010d>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1010d>;
+		};
+		cpu at 1010e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1010e>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1010e>;
+		};
+		cpu at 1010f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1010f>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1010f>;
+		};
+		cpu at 10200 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10200>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10200>;
+		};
+		cpu at 10201 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10201>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10201>;
+		};
+		cpu at 10202 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10202>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10202>;
+		};
+		cpu at 10203 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10203>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10203>;
+		};
+		cpu at 10204 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10204>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10204>;
+		};
+		cpu at 10205 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10205>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10205>;
+		};
+		cpu at 10206 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10206>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10206>;
+		};
+		cpu at 10207 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10207>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10207>;
+		};
+		cpu at 10208 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10208>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10208>;
+		};
+		cpu at 10209 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10209>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x10209>;
+		};
+		cpu at 1020a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1020a>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1020a>;
+		};
+		cpu at 1020b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1020b>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1020b>;
+		};
+		cpu at 1020c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1020c>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1020c>;
+		};
+		cpu at 1020d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1020d>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1020d>;
+		};
+		cpu at 1020e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1020e>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1020e>;
+		};
+		cpu at 1020f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1020f>;
+			enable-method = "psci";
+			arm,associativity = <1 0 0x1020f>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0xff01>,
+		             <1 14 0xff01>,
+		             <1 11 0xff01>,
+		             <1 10 0xff01>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		refclk50mhz: refclk50mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+			clock-output-names = "refclk50mhz";
+		};
+
+		gic0: interrupt-controller at 8010,00000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#redistributor-regions = <2>;
+			interrupt-controller;
+			reg = <0x8010 0x00000000 0x0 0x010000>, /* GICD */
+			      <0x8010 0x80000000 0x0 0x600000>, /* GICR Node 0 */
+			      <0x9010 0x80000000 0x0 0x600000>; /* GICR Node 1 */
+			interrupts = <1 9 0xf04>;
+		};
+
+		uaa0: serial at 87e0,24000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x87e0 0x24000000 0x0 0x1000>;
+			interrupts = <1 21 4>;
+			clocks = <&refclk50mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		uaa1: serial at 87e0,25000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x87e0 0x25000000 0x0 0x1000>;
+			interrupts = <1 22 4>;
+			clocks = <&refclk50mhz>;
+			clock-names = "apb_pclk";
+		};
+	};
+};
-- 
1.8.1.4
