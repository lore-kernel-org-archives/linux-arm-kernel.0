From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 25 Sep 2017 11:42:36 +0200
Subject: [PATCH] ARM: dts: at91: at91-sama5d27_som1: fix PHY ID
Message-ID: <20170925094236.8599-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY ID is incorrect. It leads to troubles when resuming from standby
or mem power states.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Fixes: af690fa37e39 ("ARM: dts: at91: at91-sama5d27_som1: add sama5d27 SoM1 support")
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
index 63a5af898165..cf0087b4c9e1 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -67,8 +67,8 @@
 				pinctrl-0 = <&pinctrl_macb0_default>;
 				phy-mode = "rmii";
 
-				ethernet-phy at 1 {
-					reg = <0x1>;
+				ethernet-phy at 0 {
+					reg = <0x0>;
 					interrupt-parent = <&pioA>;
 					interrupts = <PIN_PD31 IRQ_TYPE_LEVEL_LOW>;
 					pinctrl-names = "default";
-- 
2.12.2
