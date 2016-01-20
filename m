From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 11:08:55 +0100
Subject: [PATCHv2 02/16] ARM: dts: imx6ul: move tsc node to appropriate place
 in the DTB
In-Reply-To: <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453284549-16363-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the tsc node to keep the nodes sorted in ascending order by unit
address.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 99b6465..7e27d76 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -236,6 +236,17 @@
 				};
 			};
 
+			tsc: tsc at 02040000 {
+				compatible = "fsl,imx6ul-tsc";
+				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_IPG>,
+					 <&clks IMX6UL_CLK_ADC2>;
+				clock-names = "tsc", "adc";
+				status = "disabled";
+			};
+
 			gpt1: gpt at 02098000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x02098000 0x4000>;
@@ -590,17 +601,6 @@
 				status = "disabled";
 			};
 
-			tsc: tsc at 02040000 {
-				compatible = "fsl,imx6ul-tsc";
-				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
-				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_IPG>,
-					 <&clks IMX6UL_CLK_ADC2>;
-				clock-names = "tsc", "adc";
-				status = "disabled";
-			};
-
 			usdhc1: usdhc at 02190000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02190000 0x4000>;
-- 
2.1.4
