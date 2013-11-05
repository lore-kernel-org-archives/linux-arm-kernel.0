From: denis@eukrea.com (Denis Carikli)
Date: Tue,  5 Nov 2013 14:37:07 +0100
Subject: [PATCHv9][ 2/2] ARM: dts: cpuimx51 Add touchscreen support.
In-Reply-To: <1383658627-1948-1-git-send-email-denis@eukrea.com>
References: <1383658627-1948-1-git-send-email-denis@eukrea.com>
Message-ID: <1383658627-1948-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- Rebased.
- Adapted to request the tsc2007 gpio pinctrl outside of the tsc2007 bindings.

ChangeLog v7->v8:
- Added Shawn Guo in the cc list.
---
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
index b22841a..dfd9549 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -42,11 +42,23 @@
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	tsc2007: tsc2007 at 49 {
+		compatible = "ti,tsc2007";
+		reg = <0x49>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <0x0 0x8>;
+		gpios = <&gpio4 0 0>;
+		ti,x-plate-ohms = <180>;
+	};
 };
 
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	imx51-eukrea {
-		pinctrl_tsc2007_1: tsc2007grp-1 {
+		pinctrl_hog: hoggrp {
 			fsl,pins = <
 				MX51_PAD_GPIO_NAND__GPIO_NAND 0x1f5
 				MX51_PAD_NANDF_D8__GPIO4_0 0x1f5
-- 
1.7.9.5
