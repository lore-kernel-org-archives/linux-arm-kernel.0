From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 16:50:29 -0300
Subject: [PATCH 1/5] ARM: dts: imx53-ppd: Remove unnecessary
 #address/#size-cells
Message-ID: <1524513033-21136-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warnings:

arch/arm/boot/dts/imx53-ppd.dtb: Warning (avoid_unnecessary_addr_size): /power-gpio-keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm/boot/dts/imx53-ppd.dtb: Warning (avoid_unnecessary_addr_size): /touch-lock-key: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-ppd.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index d5628af..c394857 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -180,8 +180,6 @@
 
 	power-gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		power-button {
 			label = "Power button";
@@ -192,8 +190,6 @@
 
 	touch-lock-key {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		touch-lock-button {
 			label = "Touch lock button";
-- 
2.7.4
