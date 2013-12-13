From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 12 Dec 2013 18:49:13 -0700
Subject: [PATCH V1 09/11] ARM: dts: imx6qdl-sabrelite: fix ENET group
In-Reply-To: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1386899355-17379-10-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO16 is used for I2C3, not ENET_REF_CLK.
Replace MX6QDL_ENET_PINGRP1 with explicit list.
Also, remove pull-ups from tx pins.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 38b9555..24e4c81 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -210,7 +210,23 @@
 		};
 
 		pinctrl_enet: enetgrp {
-			fsl,pins = <MX6QDL_ENET_PINGRP1>;
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x100b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x100b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x100b0
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x100b0
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x100b0
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x100b0
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x100b0
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x100b0
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x100b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+			>;
 		};
 
 		pinctrl_i2c1: i2c1grp {
-- 
1.8.1.2
