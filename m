From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 28 Nov 2017 15:02:20 +0000
Subject: [PATCH v2 05/16] ARM: dts: imx6qdl-sr-som: use real iomuxc values for
 ethernet
In-Reply-To: <20171128150045.GV31757@n2100.armlinux.org.uk>
References: <20171128150045.GV31757@n2100.armlinux.org.uk>
Message-ID: <E1eJhOu-0006NV-Hs@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use real iomuxc values rather than preserving the boot loader value for
the SOMs ethernet.

Suggested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
index c1541f2ecf3a..2b332db6c20d 100644
--- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
@@ -116,10 +116,10 @@
 				/* AR8035 reset */
 				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0
 				/* AR8035 interrupt */
-				MX6QDL_PAD_DI0_PIN2__GPIO4_IO18		0x80000000
+				MX6QDL_PAD_DI0_PIN2__GPIO4_IO18		0x1b0b0
 				/* GPIO16 -> AR8035 25MHz */
-				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0xc0000000
-				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x80000000
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x13030
 				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
 				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
 				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
-- 
2.7.4
