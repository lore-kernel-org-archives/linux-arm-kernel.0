From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 30 Apr 2014 12:47:09 +0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: remove power-on gpio from pcie
Message-ID: <1398854829-3447-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This isn't compatible with the new binding and should be
handled via a proper regulator. It shouldn't be needed as
the driver has always ignored this property.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index dbbd35b89985..3db4ca4dd70c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -391,7 +391,6 @@
 
 		pinctrl_pcie: pciegrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x80000000
 				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x80000000
 			>;
 		};
@@ -483,7 +482,6 @@
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
-	power-on-gpio = <&gpio3 19 0>;
 	reset-gpio = <&gpio7 12 0>;
 	status = "okay";
 };
-- 
1.9.1
