From: c.hemp@phytec.de (Christian Hemp)
Date: Fri, 14 Nov 2014 14:32:26 +0100
Subject: [PATCH 5/5] ARM:dts:imx6:phyFLEX: Add CAN support
In-Reply-To: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
References: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1415971946-48975-6-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CAN support for Phytec phyFLEX-i.MX6 (PFL-A-02 and PBA-B-01).

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi |  4 ++++
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 7634cc1..585b4f6 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -101,6 +101,10 @@
 	};
 };
 
+&can1 {
+	status = "okay";
+};
+
 &fec {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 2d72109..19cc269 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -64,6 +64,12 @@
 	status = "disabled";
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "disabled";
+};
+
 &ecspi3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
@@ -240,6 +246,13 @@
 			>;
 		};
 
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b0
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b0
+			>;
+		};
+
 		pinctrl_gpmi_nand: gpminandgrp {
 			fsl,pins = <
 				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
-- 
1.9.1
