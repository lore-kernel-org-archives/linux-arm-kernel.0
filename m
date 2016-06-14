From: smoch@web.de (Soeren Moch)
Date: Tue, 14 Jun 2016 23:08:32 +0200
Subject: [PATCH] ARM: dts: imx6q-tbs2910: fix pcie reset polarity
Message-ID: <1465938512-3101-1-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt the
polarity of "reset-gpio" is assumed to be active-low unless a separate
property "reset-gpio-active-high" is available. So replace the inconsistent
polarity description to make the correct active-low reset behavior more
obvious.

Signed-off-by: Soeren Moch <smoch@web.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 1926b13..d7c8ccb 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -191,7 +191,7 @@
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
1.9.1
