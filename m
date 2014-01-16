From: denis@eukrea.com (Denis Carikli)
Date: Thu, 16 Jan 2014 12:08:36 +0100
Subject: [PATCHv10][ 1/2] ARM: dts: cpuimx35 Add touchscreen support.
Message-ID: <1389870518-4982-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Eric B?nard <eric@eukrea.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v10:
- Reduced Cc list, not to bother unrelated subsystem maintainers.
- Added the pinctrl node (because it is not anymore in the patch adding the cpuimx35).
- Cosmetic fix: reordered the tsc2007 node properties.

ChangeLog v7->v8:
- Added Shawn Guo in the cc list.
---
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
index 303f789..affe3a8 100644
--- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -37,6 +37,17 @@
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	tsc2007: tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		gpios = <&gpio3 2 0>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <0x2 0x8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007_1>;
+		reg = <0x48>;
+		ti,x-plate-ohms = <180>;
+	};
 };
 
 &iomuxc {
@@ -48,6 +59,10 @@
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <MX35_I2C1_PINGRP1>;
 		};
+
+		pinctrl_tsc2007_1: tsc2007grp-1 {
+			fsl,pins = <MX35_PAD_ATA_DA2__GPIO3_2 0x80000000>;
+		};
 	};
 };
 
-- 
1.7.9.5
