From: Frank.Li@freescale.com (Frank Li)
Date: Wed, 31 Oct 2012 12:24:57 +0800
Subject: [PATCH 2/4] ARM: dts: imx6q: Add ENET PTP clock pin and clock source
Message-ID: <1351657497-24923-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ENET 1588 clock input pin
MX6Q_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT
and anatop PLL8 clock source for ENET

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f3990b0..3290e61 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -580,6 +580,7 @@
 							66  0x1b0b0	/* MX6Q_PAD_RGMII_RD2__ENET_RGMII_RD2 */
 							70  0x1b0b0	/* MX6Q_PAD_RGMII_RD3__ENET_RGMII_RD3 */
 							48  0x1b0b0	/* MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL */
+							1033 0x4001b0a8	/* MX6Q_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT*/
 						>;
 					};
 
@@ -833,8 +834,8 @@
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupts = <0 118 0x04 0 119 0x04>;
-				clocks = <&clks 117>, <&clks 117>;
-				clock-names = "ipg", "ahb";
+				clocks = <&clks 117>, <&clks 117>, <&clks 177>;
+				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
 
-- 
1.7.1
