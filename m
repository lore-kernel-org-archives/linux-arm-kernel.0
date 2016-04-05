From: smoch@web.de (Soeren Moch)
Date: Tue,  5 Apr 2016 16:55:04 +0200
Subject: [PATCH] ARM: dts: imx6q-tbs2910: fix fec reset polarity
Message-ID: <1459868104-18191-1-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/net/fsl-fec.txt the polarity
of "phy-reset-gpios" is assumed to be active-low unless a separate property
"phy-reset-active-high" is available. So replace the inconsistent polarity
description to make the correct active-low reset behavior more obvious.

Signed-off-by: Soeren Moch <smoch@web.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 0da81bc..2401c6b 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -141,7 +141,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
1.9.1
