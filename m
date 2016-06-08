From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  7 Jun 2016 21:10:26 -0300
Subject: [PATCH 2/2] ARM: dts: imx6sx-sdb: Add PCIE support
In-Reply-To: <1465344626-15883-1-git-send-email-festevam@gmail.com>
References: <1465344626-15883-1-git-send-email-festevam@gmail.com>
Message-ID: <1465344626-15883-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Enable PCIE support.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index e5eafe4..2e04feb 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -129,6 +129,19 @@
 			regulator-max-microvolt = <3300000>;
 			gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		};
+
+		reg_pci: regulator at 7 {
+			compatible = "regulator-fixed";
+			reg = <7>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_pcie_reg>;
+			regulator-name = "MPCIE_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+			regulator-always-on;
+			enable-active-high;
+		};
 	};
 
 	sound {
@@ -244,6 +257,13 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
@@ -439,6 +459,18 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x10b0
+			>;
+		};
+
+		pinctrl_pcie_reg: pciereggrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0x10b0
+			>;
+		};
+
 		pinctrl_peri_3v3: peri3v3grp {
 			fsl,pins = <
 				MX6SX_PAD_QSPI1A_DATA0__GPIO4_IO_16	0x80000000
-- 
1.9.1
