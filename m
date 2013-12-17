From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:13:01 -0700
Subject: [PATCH V2 11/13] ARM: dts: imx6qdl-sabrelite: fix ENET group
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-12-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO16 is used for I2C3, not ENET_REF_CLK.
Replace MX6QDL_ENET_PINGRP1 with explicit list.
Also, remove pull-ups from tx pins, and ENET_MDIO
which has an external pull-up.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
Reviewed-by: Marek Vasut <marex@denx.de>

---
v2:  minor change to commit message
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 532a7e0..f1d8b24 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -216,7 +216,21 @@
 
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
-				MX6QDL_ENET_PINGRP1
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
 				/* Phy reset */
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x000b0
 			>;
-- 
1.8.1.2
