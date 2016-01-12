From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:27 +0100
Subject: [PATCH 10/14] ARM: dts: imx6ul: add flexcan support
In-Reply-To: <1452619291-13625-10-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-10-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-11-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 96b78a9..f1db53e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -292,6 +292,26 @@
 				status = "disabled";
 			};
 
+			can1: flexcan at 02090000 {
+				compatible = "fsl,imx6q-flexcan";
+				reg = <0x02090000 0x4000>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
+					 <&clks IMX6UL_CLK_CAN1_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			can2: flexcan at 02094000 {
+				compatible = "fsl,imx6q-flexcan";
+				reg = <0x02094000 0x4000>;
+				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_CAN2_IPG>,
+					 <&clks IMX6UL_CLK_CAN2_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
 			gpt1: gpt at 02098000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x02098000 0x4000>;
-- 
2.1.4
