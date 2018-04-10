From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Apr 2018 17:03:46 -0300
Subject: [PATCH] ARM: dts: imx6qdl-tx6: Remove 'bus-format-override' property
Message-ID: <1523390626-12216-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'bus-format-override' property is not documented nor used
anywhere else, so just remove it.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi b/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
index 5102fc4..79f2354 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
@@ -77,7 +77,6 @@
 		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
 		backlight = <&backlight>;
-		bus-format-override = "rgb24";
 
 		port {
 			lcd_panel_in: endpoint {
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi b/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
index 4c4e2e1..410972e 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
@@ -54,19 +54,16 @@
 
 	lcd-panel {
 		compatible = "edt,et057090dhu";
-		bus-format-override = "rgb24";
 		pixelclk-active = <0>;
 	};
 
 	lvds0-panel {
 		compatible = "edt,etml1010g0dka";
-		bus-format-override = "spwg-18";
 		pixelclk-active = <0>;
 	};
 
 	lvds1-panel {
 		compatible = "edt,etml1010g0dka";
-		bus-format-override = "spwg-18";
 		pixelclk-active = <0>;
 	};
 };
-- 
2.7.4
