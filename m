From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  2 Sep 2014 22:45:14 -0300
Subject: [PATCH 3/3] ARM: dts: imx6sl-evk: Fix display duplicate name warning
In-Reply-To: <1409708714-15136-1-git-send-email-festevam@gmail.com>
References: <1409708714-15136-1-git-send-email-festevam@gmail.com>
Message-ID: <1409708714-15136-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The lcdif node has a property named "display" and also a child node
called "display", which causes the following warning:

device-tree: Duplicate name in lcdif at 02220000, renamed to "display#1"

Rename the child node name in order to avoid the warning.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None. Newly introduced in this version

 arch/arm/boot/dts/imx6sl-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 9925c4a..898d14f 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -546,10 +546,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
 	lcd-supply = <&reg_lcd_3v3>;
-	display = <&display>;
+	display = <&display0>;
 	status = "okay";
 
-	display: display {
+	display0: display0 {
 		bits-per-pixel = <32>;
 		bus-width = <24>;
 
-- 
1.9.1
