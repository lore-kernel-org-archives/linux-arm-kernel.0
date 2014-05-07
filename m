From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  7 May 2014 20:09:04 +0200
Subject: [PATCH 1/2] ARM: dts: imx6: edmqmx6: add pinctrl for pfuze irq gpio
Message-ID: <1399486145-24913-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index e4ae38fd0269..be5de70fe86a 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -105,7 +105,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2
 		     &pinctrl_stmpe1
-		     &pinctrl_stmpe2>;
+		     &pinctrl_stmpe2
+		     &pinctrl_pfuze>;
 	status = "okay";
 
 	pmic: pfuze100 at 08 {
@@ -291,6 +292,12 @@
 			>;
 		};
 
+		pinctrl_pfuze: pfuze100grp1 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x80000000
+			>;
+		};
+
 		pinctrl_stmpe1: stmpe1grp {
 			fsl,pins = <MX6QDL_PAD_EIM_D30__GPIO3_IO30 0x80000000>;
 		};
-- 
2.0.0.rc0
