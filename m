From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Tue, 16 May 2017 15:07:21 +0300
Subject: [PATCH 1/3] arm64: dts: add DPAA FMan nodes
In-Reply-To: <1494936443-14869-1-git-send-email-madalin.bucur@nxp.com>
References: <1494936443-14869-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1494936443-14869-2-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DPAA 1.x FMan nodes for the ARM based platforms.

Using separate files for each port as not all ports are used on all
devices. Different numbering of ports is also possible on different
devices.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    | 42 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    | 42 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     | 41 +++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     | 41 +++++++++++
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   | 81 ++++++++++++++++++++++
 9 files changed, 411 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi

diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
new file mode 100644
index 0000000..ecdffe7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
@@ -0,0 +1,42 @@
+/*
+ * QorIQ FMan v3 10g port #0 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x10: port at 90000 {
+		cell-index = <0x10>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x90000 0x1000>;
+		fsl,fman-10g-port;
+	};
+
+	fman0_tx_0x30: port at b0000 {
+		cell-index = <0x30>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xb0000 0x1000>;
+		fsl,fman-10g-port;
+	};
+
+	ethernet at f0000 {
+		cell-index = <0x8>;
+		compatible = "fsl,fman-memac";
+		reg = <0xf0000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x10 &fman0_tx_0x30>;
+		pcsphy-handle = <&pcsphy6>;
+	};
+
+	mdio at f1000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xf1000 0x1000>;
+
+		pcsphy6: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
new file mode 100644
index 0000000..a7f6af5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -0,0 +1,42 @@
+/*
+ * QorIQ FMan v3 10g port #1 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x11: port at 91000 {
+		cell-index = <0x11>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x91000 0x1000>;
+		fsl,fman-10g-port;
+	};
+
+	fman0_tx_0x31: port at b1000 {
+		cell-index = <0x31>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xb1000 0x1000>;
+		fsl,fman-10g-port;
+	};
+
+	ethernet at f2000 {
+		cell-index = <0x9>;
+		compatible = "fsl,fman-memac";
+		reg = <0xf2000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x11 &fman0_tx_0x31>;
+		pcsphy-handle = <&pcsphy7>;
+	};
+
+	mdio at f3000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xf3000 0x1000>;
+
+		pcsphy7: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
new file mode 100644
index 0000000..d600786
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ FMan v3 1g port #0 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x08: port at 88000 {
+		cell-index = <0x8>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x88000 0x1000>;
+	};
+
+	fman0_tx_0x28: port at a8000 {
+		cell-index = <0x28>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xa8000 0x1000>;
+	};
+
+	ethernet at e0000 {
+		cell-index = <0>;
+		compatible = "fsl,fman-memac";
+		reg = <0xe0000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
+		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy0>;
+	};
+
+	mdio at e1000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xe1000 0x1000>;
+
+		pcsphy0: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
new file mode 100644
index 0000000..3c0b76d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ FMan v3 1g port #1 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x09: port at 89000 {
+		cell-index = <0x9>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x89000 0x1000>;
+	};
+
+	fman0_tx_0x29: port at a9000 {
+		cell-index = <0x29>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xa9000 0x1000>;
+	};
+
+	ethernet at e2000 {
+		cell-index = <1>;
+		compatible = "fsl,fman-memac";
+		reg = <0xe2000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
+		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy1>;
+	};
+
+	mdio at e3000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xe3000 0x1000>;
+
+		pcsphy1: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
new file mode 100644
index 0000000..89633af
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ FMan v3 1g port #2 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x0a: port at 8a000 {
+		cell-index = <0xa>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x8a000 0x1000>;
+	};
+
+	fman0_tx_0x2a: port at aa000 {
+		cell-index = <0x2a>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xaa000 0x1000>;
+	};
+
+	ethernet at e4000 {
+		cell-index = <2>;
+		compatible = "fsl,fman-memac";
+		reg = <0xe4000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x0a &fman0_tx_0x2a>;
+		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy2>;
+	};
+
+	mdio at e5000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xe5000 0x1000>;
+
+		pcsphy2: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
new file mode 100644
index 0000000..87c2b70
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ FMan v3 1g port #3 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x0b: port at 8b000 {
+		cell-index = <0xb>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x8b000 0x1000>;
+	};
+
+	fman0_tx_0x2b: port at ab000 {
+		cell-index = <0x2b>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xab000 0x1000>;
+	};
+
+	ethernet at e6000 {
+		cell-index = <3>;
+		compatible = "fsl,fman-memac";
+		reg = <0xe6000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x0b &fman0_tx_0x2b>;
+		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy3>;
+	};
+
+	mdio at e7000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xe7000 0x1000>;
+
+		pcsphy3: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
new file mode 100644
index 0000000..8f4d74b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ FMan v3 1g port #4 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x0c: port at 8c000 {
+		cell-index = <0xc>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x8c000 0x1000>;
+	};
+
+	fman0_tx_0x2c: port at ac000 {
+		cell-index = <0x2c>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xac000 0x1000>;
+	};
+
+	ethernet at e8000 {
+		cell-index = <4>;
+		compatible = "fsl,fman-memac";
+		reg = <0xe8000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x0c &fman0_tx_0x2c>;
+		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy4>;
+	};
+
+	mdio at e9000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xe9000 0x1000>;
+
+		pcsphy4: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
new file mode 100644
index 0000000..d534f77
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ FMan v3 1g port #5 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman at 1a00000 {
+	fman0_rx_0x0d: port at 8d000 {
+		cell-index = <0xd>;
+		compatible = "fsl,fman-v3-port-rx";
+		reg = <0x8d000 0x1000>;
+	};
+
+	fman0_tx_0x2d: port at ad000 {
+		cell-index = <0x2d>;
+		compatible = "fsl,fman-v3-port-tx";
+		reg = <0xad000 0x1000>;
+	};
+
+	ethernet at ea000 {
+		cell-index = <5>;
+		compatible = "fsl,fman-memac";
+		reg = <0xea000 0x1000>;
+		fsl,fman-ports = <&fman0_rx_0x0d &fman0_tx_0x2d>;
+		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy5>;
+	};
+
+	mdio at eb000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xeb000 0x1000>;
+
+		pcsphy5: ethernet-phy at 0 {
+			reg = <0x0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
new file mode 100644
index 0000000..4dd0676
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -0,0 +1,81 @@
+/*
+ * QorIQ FMan v3 device tree
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+fman0: fman at 1a00000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cell-index = <0>;
+	compatible = "fsl,fman";
+	ranges = <0x0 0x0 0x1a00000 0x100000>;
+	reg = <0x0 0x1a00000 0x0 0x100000>;
+	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clockgen 3 0>;
+	clock-names = "fmanclk";
+	fsl,qman-channel-range = <0x800 0x10>;
+
+	muram at 0 {
+		compatible = "fsl,fman-muram";
+		reg = <0x0 0x60000>;
+	};
+
+	fman0_oh_0x2: port at 82000 {
+		cell-index = <0x2>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x82000 0x1000>;
+	};
+
+	fman0_oh_0x3: port at 83000 {
+		cell-index = <0x3>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x83000 0x1000>;
+	};
+
+	fman0_oh_0x4: port at 84000 {
+		cell-index = <0x4>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x84000 0x1000>;
+	};
+
+	fman0_oh_0x5: port at 85000 {
+		cell-index = <0x5>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x85000 0x1000>;
+	};
+
+	fman0_oh_0x6: port at 86000 {
+		cell-index = <0x6>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x86000 0x1000>;
+	};
+
+	fman0_oh_0x7: port at 87000 {
+		cell-index = <0x7>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x87000 0x1000>;
+	};
+
+	mdio0: mdio at fc000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xfc000 0x1000>;
+	};
+
+	xmdio0: mdio at fd000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xfd000 0x1000>;
+	};
+
+	ptp_timer0: ptp-timer at fe000 {
+		compatible = "fsl,fman-ptp-timer";
+		reg = <0xfe000 0x1000>;
+	};
+};
-- 
2.1.0
