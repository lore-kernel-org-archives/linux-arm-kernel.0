From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 15 Aug 2014 15:19:13 +0530
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
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
 arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   29 ++++++
 arch/arm64/boot/dts/fsl-ls2085a.dtsi     |  145 ++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

diff --git a/arch/arm64/boot/dts/fsl-ls2085a-simu.dts b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
new file mode 100644
index 0000000..8a55710
--- /dev/null
+++ b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
@@ -0,0 +1,29 @@
+/*
+ * Device Tree file for Freescale LS2085a software Simulator model
+ *
+ * Copyright (C) 2014, Freescale Semiconductor
+ *
+ * Bhupesh Sharma <bhupesh.sharma@freescale.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
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
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		compatible = "smsc,lan91c111";
+		reg = <0x0 0x2210000 0x0 0x100>;
+		interrupts = <0 58 0x1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
new file mode 100644
index 0000000..aca48ac
--- /dev/null
+++ b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
@@ -0,0 +1,145 @@
+/*
+ * Device Tree Include file for Freescale Layerscape-2085A family SoC.
+ *
+ * Copyright (C) 2014, Freescale Semiconductor
+ *
+ * Bhupesh Sharma <bhupesh.sharma@freescale.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/* Preventing Linux from using the following memory chunk */
+/memreserve/ 0x80000000 0x00010000;
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
+		/* We have 4 clusters having 2 Cortex-A57 cores each */
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x201>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+
+		cpu at 300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x300>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+
+		cpu at 301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x0 0x301>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+	};
+
+	gic: interrupt-controller at 6000000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
+		      <0x0 0x06100000 0 0x100000>; /* GICR (RD_base + SGI_base) */
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		interrupts = <1 9 0xf04>;
+
+		its: gic-its at 6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x6020000 0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0x01>, /* Physical Secure PPI, edge triggered */
+			     <1 14 0x01>, /* Physical Non-Secure PPI, edge triggered */
+			     <1 0 0x01>,  /* Virtual PPI, edge triggered */
+			     <1 10 0x01>; /* Hypervisor PPI, edge triggered */
+	};
+
+	serial0: serial at 21c4500 {
+		device_type = "serial";
+		compatible = "fsl,ns16550", "ns16550a";
+		reg = <0x0 0x21c4500 0x0 0x100>;
+		clock-frequency = <0>;
+		interrupts = <0 32 0x1>; /* edge triggered */
+	};
+
+	serial1: serial at 21c4600 {
+		device_type = "serial";
+		compatible = "fsl,ns16550", "ns16550a";
+		reg = <0x0 0x21c4600 0x0 0x100>;
+		clock-frequency = <0>;
+		interrupts = <0 32 0x1>; /* edge triggered */
+	};
+
+	fsl_mc: fsl-mc at 80c000000 {
+		compatible = "fsl,qoriq-mc";
+		reg = <0x00000008 0x0c000000 0 0x40	/* MC portal base */
+		       0x00000000 0x08340000 0 0x40000 >; /* MC control reg */
+		};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>;
+		      /* DRAM space 1 - 2 GB DRAM */
+	};
+};
-- 
1.7.9.5
