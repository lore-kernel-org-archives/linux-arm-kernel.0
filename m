From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 Apr 2014 17:13:22 -0300
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Move FEC reset pin into the FEC
 pin group
Message-ID: <1398284002-14396-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Remove GPIO3_29 (FEC PHY reset pin) from the hog group and place it into
pinctrl_enet pin group instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 5c6f10c..79498ca 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -104,7 +104,6 @@
 				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x80000000 /* WL_REG_ON */
 				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000 /* WL_HOST_WAKE */
 				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x80000000 /* WL_WAKE */
-				MX6QDL_PAD_EIM_D29__GPIO3_IO29   0x80000000
 			>;
 		};
 
@@ -136,6 +135,7 @@
 				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
 				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
 				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29   	0x80000000
 			>;
 		};
 
-- 
1.8.3.2
