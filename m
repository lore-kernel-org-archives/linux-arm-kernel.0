From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:07 +0100
Subject: [PATCH 137/222] ARM: dt: microsom: don't set bit 7 for ethernet mux
 settings
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeX5-0007MP-9i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bit 6,7 are marked as reserved for the ethernet RGMII pins, so avoid
setting these bits.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
index a3cb2fff8f61..d16066608e21 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
@@ -26,25 +26,25 @@
 				/* GPIO16 -> AR8035 25MHz */
 				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0xc0000000
 				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x80000000
-				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
-				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
-				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
-				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
-				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
 				/* AR8035 CLK_25M --> ENET_REF_CLK (V22) */
 				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x0a0b1
 				/* AR8035 pin strapping: IO voltage: pull up */
-				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
 				/* AR8035 pin strapping: PHYADDR#0: pull down */
-				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x130b0
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x13030
 				/* AR8035 pin strapping: PHYADDR#1: pull down */
-				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x130b0
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x13030
 				/* AR8035 pin strapping: MODE#1: pull up */
-				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
 				/* AR8035 pin strapping: MODE#3: pull up */
-				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
 				/* AR8035 pin strapping: MODE#0: pull down */
-				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x130b0
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x13030
 
 				/*
 				 * As the RMII pins are also connected to RGMII
-- 
1.8.3.1
