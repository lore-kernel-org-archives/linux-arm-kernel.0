From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 11 Oct 2014 04:10:47 +0530
Subject: [PATCH V4 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1412980849-21318-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1412980849-21318-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1412980849-21318-5-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree support for FSL LS2085A SoC
based on ARMv8 architecture.

Following levels of DTSI/DTS files have been created for the
LS2085A SoC family:

- fsl-ls2085a.dtsi:
DTS-Include file for FSL LS2085A SoC.

- fsl-ls2085a-simu.dts:
DTS file for FSL LS2085a software simulator model.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Arnab Basu <arnab.basu@freescale.com>
Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   65 ++++++++++++
 arch/arm64/boot/dts/fsl-ls2085a.dtsi     |  162 ++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

diff --git a/arch/arm64/boot/dts/fsl-ls2085a-simu.dts b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
new file mode 100644
index 0000000..82e2a6f
--- /dev/null
+++ b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
@@ -0,0 +1,65 @@
+/*
+ * Device Tree file for Freescale LS2085a software Simulator model
+ *
+ * Copyright (C) 2014, Freescale Semiconductor
+ *
+ * Bhupesh Sharma <bhupesh.sharma@freescale.com>
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
+/include/ "fsl-ls2085a.dtsi"
+
+/ {
+	model = "Freescale Layerscape 2085a software Simulator model";
+	compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
+
+	ethernet at 2210000 {
+		compatible = "smsc,lan91c111";
+		reg = <0x0 0x2210000 0x0 0x100>;
+		interrupts = <0 58 0x1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
new file mode 100644
index 0000000..1da7947
--- /dev/null
+++ b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
@@ -0,0 +1,162 @@
+/*
+ * Device Tree Include file for Freescale Layerscape-2085A family SoC.
+ *
+ * Copyright (C) 2014, Freescale Semiconductor
+ *
+ * Bhupesh Sharma <bhupesh.sharma@freescale.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
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
+	compatible = "fsl,ls2085a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		/* We expect the enable-method for cpu's to be "psci", but this
+		 * is dependent on the SoC FW, which will fill this in.
+		 *
+		 * Currently supported enable-method is psci v0.2
+		 */
+
+		/* We have 4 clusters having 2 Cortex-A57 cores each */
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x1>;
+		};
+
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x100>;
+		};
+
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x101>;
+		};
+
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x200>;
+		};
+
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x201>;
+		};
+
+		cpu at 300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x300>;
+		};
+
+		cpu at 301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x301>;
+		};
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>;
+		      /* DRAM space - 1, size : 2 GB DRAM */
+	};
+
+	gic: interrupt-controller at 6000000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
+		      <0x0 0x06100000 0 0x100000>; /* GICR (RD_base + SGI_base) */
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <1 9 0x4>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0x1>, /* Physical Secure PPI, edge triggered */
+			     <1 14 0x1>, /* Physical Non-Secure PPI, edge triggered */
+			     <1 11 0x1>, /* Virtual PPI, edge triggered */
+			     <1 10 0x1>; /* Hypervisor PPI, edge triggered */
+	};
+
+	serial0: serial at 21c0500 {
+		device_type = "serial";
+		compatible = "fsl,ns16550", "ns16550a";
+		reg = <0x0 0x21c0500 0x0 0x100>;
+		clock-frequency = <0>;	/* Updated by bootloader */
+		interrupts = <0 32 0x1>; /* edge triggered */
+	};
+
+	serial1: serial at 21c0600 {
+		device_type = "serial";
+		compatible = "fsl,ns16550", "ns16550a";
+		reg = <0x0 0x21c0600 0x0 0x100>;
+		clock-frequency = <0>; 	/* Updated by bootloader */
+		interrupts = <0 32 0x1>; /* edge triggered */
+	};
+
+	fsl_mc: fsl-mc at 80c000000 {
+		compatible = "fsl,qoriq-mc";
+		reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
+		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
+	};
+};
-- 
1.7.9.5
