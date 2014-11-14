From: c.hemp@phytec.de (Christian Hemp)
Date: Fri, 14 Nov 2014 14:32:25 +0100
Subject: [PATCH 4/5] ARM:dts:imx6:phyFLEX: Add PCIe
In-Reply-To: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
References: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1415971946-48975-5-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCIe support for Phytec phyFLEX-i.MX6 (PFL-A-02 and PBA-B-01).

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi |  4 ++++
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 111b1f5..7634cc1 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -144,6 +144,10 @@
 	status = "okay";
 };
 
+&pcie {
+	status = "okay";
+};
+
 &ssi2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 8d718b5..2d72109 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -283,6 +283,10 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000>;
+		};
+
 		pinctrl_uart3: uart3grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
@@ -353,6 +357,13 @@
 	};
 };
 
+&pcie {
+	pinctrl-name = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio4 17 0>;
+	status = "disabled";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
1.9.1
