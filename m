From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 14 Oct 2017 09:43:22 -0300
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Add support for the revd1
 variants
Message-ID: <1507985002-11626-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Latest wandboard hardware revision is revd1, which brings the following
new features:

- PFUZE100 PMIC
- AR8035 Ethernet PHY
- Upgrade Wifi/BT chip to BCM4339/BCM43430.

Add support for the mx6, mx6dl and mx6qp revd1 variants.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/Makefile                     |   3 +
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts   |  22 +++
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts    |  26 ++++
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi | 196 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts   |  22 +++
 5 files changed, 269 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 097a1e5..7a540ff 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -396,6 +396,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-udoo.dtb \
 	imx6dl-wandboard.dtb \
 	imx6dl-wandboard-revb1.dtb \
+	imx6dl-wandboard-revd1.dtb \
 	imx6q-apalis-eval.dtb \
 	imx6q-apalis-ixora.dtb \
 	imx6q-apalis-ixora-v1.1.dtb \
@@ -453,11 +454,13 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-utilite-pro.dtb \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
+	imx6q-wandboard-revd1.dtb \
 	imx6q-zii-rdu2.dtb \
 	imx6qp-nitrogen6_max.dtb \
 	imx6qp-nitrogen6_som2.dtb \
 	imx6qp-sabreauto.dtb \
 	imx6qp-sabresd.dtb \
+	imx6qp-wandboard-revd1.dtb \
 	imx6qp-zii-rdu2.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
new file mode 100644
index 0000000..aa4d4fa
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-wandboard-revd1.dtsi"
+
+/ {
+	model = "Wandboard i.MX6 Dual Lite Board revD1";
+	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
new file mode 100644
index 0000000..e87ddb1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-wandboard-revd1.dtsi"
+
+/ {
+	model = "Wandboard i.MX6 Quad Board revD1";
+	compatible = "wand,imx6q-wandboard", "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
new file mode 100644
index 0000000..1ae9696
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
@@ -0,0 +1,196 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include "imx6qdl-wandboard.dtsi"
+
+/ {
+	reg_eth_phy: regulator-eth-phy {
+		compatible = "regulator-fixed";
+		regulator-name = "ETH_PHY";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio7 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	pmic: pfuze100 at 08 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&fec {
+	phy-supply = <&reg_eth_phy>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx6qdl-wandboard {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1     	0x130b0
+				MX6QDL_PAD_EIM_D22__USB_OTG_PWR		0x80000000	/* USB Power Enable */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* USDHC1 CD */
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29   	0x1f0b1		/* RGMII PHY reset */
+			>;
+		};
+
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
+				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_GPIO_16__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_spdif: spdifgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_19__SPDIF_OUT		0x1b0b0
+			>;
+		};
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
new file mode 100644
index 0000000..7df5d96
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+/dts-v1/;
+#include "imx6qp.dtsi"
+#include "imx6qdl-wandboard-revd1.dtsi"
+
+/ {
+	model = "Wandboard i.MX6 QuadPlus Board revD1";
+	compatible = "wand,imx6qp-wandboard", "fsl,imx6qp";
+
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+};
-- 
2.7.4
