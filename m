From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 25 Nov 2017 20:51:07 -0200
Subject: [PATCH] ARM: dts: imx53-cx9020: Fix the Ethernet PHY reset GPIO
 polarity
Message-ID: <1511650267-21933-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As explained in Documentation/devicetree/bindings/net/fsl-fec.txt the
phy-reset-gpios is active high only if the 'phy-reset-active-high' is
present.

As 'phy-reset-active-high' is not used here, fix the device tree
description by passing GPIO_ACTIVE_LOW flag.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-cx9020.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-cx9020.dts b/arch/arm/boot/dts/imx53-cx9020.dts
index 4f54fd4..5e67e43 100644
--- a/arch/arm/boot/dts/imx53-cx9020.dts
+++ b/arch/arm/boot/dts/imx53-cx9020.dts
@@ -152,7 +152,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.7.4
