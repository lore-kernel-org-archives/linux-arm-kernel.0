From: diego.dorta@nxp.com (Diego Dorta)
Date: Wed, 15 Jun 2016 13:34:41 -0300
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Fix Ethernet PHY reset GPIO
Message-ID: <1466008481-10576-1-git-send-email-diego.dorta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the imx6ul-pico-hobbit schematics the Ethernet PHY reset GPIO
is GPIO1_28, so fix it accordingly.

Also adjust the reset duration to 1ms, because the KSZ8081 datasheet
requires 500?s.

Signed-off-by: Diego Dorta <diego.dorta@nxp.com>
---
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 8ce1fec..e760cda 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -151,8 +151,8 @@
 	phy-mode = "rmii";
 	phy-handle = <&ethphy1>;
 	status = "okay";
-	phy-reset-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <11>;
+	phy-reset-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <1>;
 
 	mdio {
 		#address-cells = <1>;
-- 
2.7.4
