From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Fri, 11 Nov 2016 16:59:38 +0100
Subject: [PATCH 1/2] ARM: dts: imx6q-cm-fx6: fix fec pinctrl
Message-ID: <6cd823201b9f4cde8de8eddc910f39ce@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

According to the schematics of CompuLab's sbc-fx6 baseboard and the
vendor devicetree GPIO_16 is *not* muxed to ENET_REF_CLK but to SPDIF_IN.

Remove the wrong pinctrl setting.

Fixes: 682d055e6ac5 ("ARM: dts: Add initial support for cm-fx6.")
Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 59bc5a4..a150bca 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -183,7 +183,6 @@
 			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
 			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
 		>;
 	};
 
-- 
2.10.2
