From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  2 Sep 2014 22:45:12 -0300
Subject: [PATCH v2 1/3] ARM: dts: imx28-evk: Fix display duplicate name warning
Message-ID: <1409708714-15136-1-git-send-email-festevam@gmail.com>
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
- Rename the child node

 arch/arm/boot/dts/imx28-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e4cc44c..09664fc 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -124,10 +124,10 @@
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_evk>;
 				lcd-supply = <&reg_lcd_3v3>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <32>;
 					bus-width = <24>;
 
-- 
1.9.1
