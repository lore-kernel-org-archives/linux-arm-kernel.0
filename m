From: aalonso@freescale.com (Adrian Alonso)
Date: Mon, 28 Sep 2015 16:56:35 -0500
Subject: [PATCH v7 1/7] ARM: dts: imx: imx7d-sbd remove fixed can2-3v3
 regulator
Message-ID: <1443477401-17238-1-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove incorrect can2-3v3 fixed regulator, imx7d-sdb doesn't
have a dedicated can2 fixed regulator instead it shares PERI_3V3
fixed regulator (RT8070ZS) which is enabled by default (hardwired)
from pmic pfuze3000 NVCC_3V3 power rail.

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V7: New patch in series

 arch/arm/boot/dts/imx7d-sdb.dts | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 8059458..83f0053 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -78,16 +78,7 @@
 			enable-active-high;
 		};
 
-		reg_can2_3v3: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "can2-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
-		};
-
-		reg_vref_1v8: regulator at 3 {
+		reg_vref_1v8: regulator at 2 {
 			compatible = "regulator-fixed";
 			reg = <3>;
 			regulator-name = "vref-1v8";
-- 
2.1.4
