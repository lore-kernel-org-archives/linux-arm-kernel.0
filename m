From: marco.franchi@nxp.com (Marco Franchi)
Date: Tue, 11 Jul 2017 12:28:23 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul-evk: Pass the 'backlight' property
In-Reply-To: <1499786903-14600-1-git-send-email-marco.franchi@nxp.com>
References: <1499786903-14600-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1499786903-14600-2-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the 'backlight' property as described in
Documentation/devicetree/bindings/display/panel/simple-panel.txt

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index e08237f..5341798 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -22,7 +22,7 @@
 		reg = <0x80000000 0x20000000>;
 	};
 
-	backlight {
+	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -81,6 +81,7 @@
 
 	panel {
 		compatible = "innolux,at043tn24";
+		backlight = <&backlight_display>;
 
 		port {
 			panel_in: endpoint {
-- 
2.7.4
