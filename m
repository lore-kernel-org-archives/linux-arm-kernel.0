From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  4 Sep 2014 22:31:22 -0300
Subject: [PATCH v2 5/6] ARM: dts: imx28-tx28: Fix display duplicate name
 warning
In-Reply-To: <1409880683-27402-1-git-send-email-festevam@gmail.com>
References: <1409880683-27402-1-git-send-email-festevam@gmail.com>
Message-ID: <1409880683-27402-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The lcdif node has a property named "display" and also a child node
called "display", which causes the following warning:

device-tree: Duplicate name in lcdif at 80030000, renamed to "display#1"

Rename the child node name in order to avoid the warning.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Also update 'aliases'

 arch/arm/boot/dts/imx28-tx28.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index e14bd86..f947fbb 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -21,7 +21,7 @@
 	aliases {
 		can0 = &can0;
 		can1 = &can1;
-		display = &display;
+		display = &display0;
 		ds1339 = &ds1339;
 		gpio5 = &gpio5;
 		lcdif = &lcdif;
@@ -309,10 +309,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcdif_24bit_pins_a &lcdif_sync_pins_a &tx28_lcdif_ctrl_pins>;
 	lcd-supply = <&reg_lcd>;
-	display = <&display>;
+	display = <&display0>;
 	status = "okay";
 
-	display: display at 0 {
+	display0: display0 {
 		bits-per-pixel = <32>;
 		bus-width = <24>;
 		display-timings {
-- 
1.9.1
