From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:19 +0100
Subject: [PATCH 18/77] ARM: dts: sun5i: Fix Display Engine DTC warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <f2dbd10e7c99093198e133197e3cd5ad07cf7256.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our display engine endpoints trigger some DTC warnings due to the fact that
we're having a single endpoint that doesn't need any reg property, and
since we don't have a reg property, we don't need the address-cells and
size-cells properties anymore.

Fix those

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts |  2 --
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 10 ++--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 8855ddb78e0b..0dafbdb00599 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -74,8 +74,6 @@
 
 	bridge {
 		compatible = "dumb-vga-dac";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		ports {
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
index a89f29fa3e40..85edbd98f7db 100644
--- a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -50,18 +50,12 @@
 
 	panel: panel {
 		compatible = "urt,umsh-8596md-t", "simple-panel";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		port at 0 {
-			reg = <0>;
+		port {
 			/* TODO: lcd panel uses axp gpio0 as enable pin */
 			backlight = <&backlight>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 
-			panel_input: endpoint at 0 {
-				reg = <0>;
+			panel_input: endpoint {
 				remote-endpoint = <&tcon0_out_lcd>;
 			};
 		};
-- 
git-series 0.9.1
