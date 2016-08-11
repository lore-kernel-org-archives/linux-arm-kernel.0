From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 11 Aug 2016 10:35:16 -0700
Subject: [PATCH V2 1/1] ARM: dts: imx6q-evi: Use GPIO_6 for fec irq
In-Reply-To: <57ACB493.4040809@gmail.com>
References: <57ACB493.4040809@gmail.com>
Message-ID: <1470936916-20913-1-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apply hardware workaround for ethernet problem
See nxp erratum err006687

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---

Changed since V1:
- added fsl,err006687-workaround-present; so that it will continue to work

 arch/arm/boot/dts/imx6q-evi.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index 49c6f61..33bd04b 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -127,6 +127,8 @@
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio1 25 0>;
+	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
+			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
+	fsl,err006687-workaround-present;
 	status = "okay";
 };
 
@@ -312,6 +314,7 @@
 			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
 			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN 0x4001b0a8
 			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x1b0b0
+			MX6QDL_PAD_GPIO_6__ENET_IRQ 0x000b1
 		>;
 	};
 
-- 
2.7.4
