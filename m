From: c.hemp@phytec.de (Christian Hemp)
Date: Fri, 14 Nov 2014 14:32:22 +0100
Subject: [PATCH 1/5] ARM:dts:imx6:phyFLEX: set nodes in alphabetical order
In-Reply-To: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
References: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1415971946-48975-2-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gmpi and fec node were not in alphabatical order.

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index ab3b1f9..585b823 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -78,6 +78,22 @@
 	};
 };
 
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
+	phy-supply = <&vdd_eth_io_reg>;
+	status = "disabled";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "disabled";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
@@ -337,22 +353,6 @@
 	};
 };
 
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
-	phy-supply = <&vdd_eth_io_reg>;
-	status = "disabled";
-};
-
-&gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
-	status = "disabled";
-};
-
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
1.9.1
