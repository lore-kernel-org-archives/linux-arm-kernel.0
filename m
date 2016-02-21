From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Sun, 21 Feb 2016 12:18:03 +0100
Subject: [PATCH V2 1/4] ARM: dts: imx6ul: Add flexcan1 and flexcan2 support
In-Reply-To: <CAOMZO5DfKi5KymQ6p9yF4ntqEJ7O=EEE7CKFmS-0N2XL8=ET7A@mail.gmail.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
 <1455963652-24618-2-git-send-email-michael@amarulasolutions.com>
 <CAOMZO5Bk_ZMhYzFLRFNK2TQvK4KHuj62AM_6uF-m-P1kJupTHQ@mail.gmail.com>
 <20160220171816.GA24064@panicking>
 <CAOMZO5DfKi5KymQ6p9yF4ntqEJ7O=EEE7CKFmS-0N2XL8=ET7A@mail.gmail.com>
Message-ID: <20160221111759.GA5387@panicking>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for FLEXCAN1 and FLEXCAN2.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes in V2:
	- remove stop-mode property because is not handle in
	  mainline

 arch/arm/boot/dts/imx6ul.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 99b6465..f7b852e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -14,6 +14,8 @@
 
 / {
 	aliases {
+		can0 = &flexcan1;
+		can1 = &flexcan2;
 		ethernet0 = &fec1;
 		ethernet1 = &fec2;
 		gpio0 = &gpio1;
@@ -234,6 +236,26 @@
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
+
+				flexcan1: can at 02090000 {
+					compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
+					reg = <0x02090000 0x4000>;
+					interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
+						 <&clks IMX6UL_CLK_CAN1_SERIAL>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				flexcan2: can at 02094000 {
+					compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
+					reg = <0x02094000 0x4000>;
+					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_CAN2_IPG>,
+						 <&clks IMX6UL_CLK_CAN2_SERIAL>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 			};
 
 			gpt1: gpt at 02098000 {
-- 
2.7.0

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
