From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 Dec 2013 16:25:17 +0100
Subject: [PATCH] ARM: dts: imx6q-sabrelite: PHY reset is active-low
Message-ID: <1387553117-30936-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that the fec driver code currently hard-codes an active-low
reset, regardless of the flags in the device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index f004913..338d558 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include "imx6q.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Lite Board";
@@ -89,7 +90,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_1>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 0>;
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
1.8.5.1
