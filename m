From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Mon, 15 May 2017 12:21:16 +0300
Subject: [PATCH v2 1/3] arm64: dts: add DPAA QBMan portals
In-Reply-To: <1494840078-22243-1-git-send-email-madalin.bucur@nxp.com>
References: <1494840078-22243-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1494840078-22243-2-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DPAA 1.x DPAA QMan and BMan portal nodes.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 .../boot/dts/freescale/qoriq-bman-portals.dtsi     | 71 +++++++++++++++++++
 .../boot/dts/freescale/qoriq-qman-portals.dtsi     | 80 ++++++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi

diff --git a/arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
new file mode 100644
index 0000000..c3c2be4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
@@ -0,0 +1,71 @@
+/*
+ * QorIQ BMan Portals device tree
+ *
+ * Copyright 2011-2016 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+&bportals {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+
+	bman-portal at 0 {
+		/*
+		 * bootloader fix-ups are expected to provide the
+		 * "fsl,bman-portal-<hardware revision>" compatible
+		 */
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x4000000 0x4000>;
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 10000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x10000 0x4000>, <0x4010000 0x4000>;
+		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 20000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x20000 0x4000>, <0x4020000 0x4000>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 30000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x30000 0x4000>, <0x4030000 0x4000>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 40000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x40000 0x4000>, <0x4040000 0x4000>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 50000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x50000 0x4000>, <0x4050000 0x4000>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 60000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x60000 0x4000>, <0x4060000 0x4000>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 70000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x70000 0x4000>, <0x4070000 0x4000>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	bman-portal at 80000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x80000 0x4000>, <0x4080000 0x4000>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi
new file mode 100644
index 0000000..2a9aa06
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi
@@ -0,0 +1,80 @@
+/*
+ * QorIQ QMan Portals device tree
+ *
+ * Copyright 2011-2016 Freescale Semiconductor Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+ */
+
+&qportals {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+
+	qportal0: qman-portal at 0 {
+		/*
+		 * bootloader fix-ups are expected to provide the
+		 * "fsl,bman-portal-<hardware revision>" compatible
+		 */
+		compatible = "fsl,qman-portal";
+		reg = <0x0 0x4000>, <0x4000000 0x4000>;
+		interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <0>;
+	};
+
+	qportal1: qman-portal at 10000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x10000 0x4000>, <0x4010000 0x4000>;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <1>;
+	};
+
+	qportal2: qman-portal at 20000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x20000 0x4000>, <0x4020000 0x4000>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <2>;
+	};
+
+	qportal3: qman-portal at 30000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x30000 0x4000>, <0x4030000 0x4000>;
+		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <3>;
+	};
+
+	qportal4: qman-portal at 40000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x40000 0x4000>, <0x4040000 0x4000>;
+		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <4>;
+	};
+
+	qportal5: qman-portal at 50000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x50000 0x4000>, <0x4050000 0x4000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <5>;
+	};
+
+	qportal6: qman-portal at 60000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x60000 0x4000>, <0x4060000 0x4000>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <6>;
+	};
+
+	qportal7: qman-portal at 70000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x70000 0x4000>, <0x4070000 0x4000>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <7>;
+	};
+
+	qportal8: qman-portal at 80000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x80000 0x4000>, <0x4080000 0x4000>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <8>;
+	};
+};
-- 
2.1.0
