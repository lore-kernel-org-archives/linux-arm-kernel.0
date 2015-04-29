From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Apr 2015 15:58:07 -0300
Subject: [PATCH] ARM: dts: imx6sl-warp: Fix unused regulator
Message-ID: <1430333887-13252-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The 'reg_1p8v' regulator is not used anywhere, so let's remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 64f7dec..232597a 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -82,14 +82,6 @@
 			gpio = <&gpio4 2 0>;
 			enable-active-high;
 		};
-
-		reg_1p8v: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "1P8V";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
 	};
 
 	usdhc3_pwrseq: usdhc3_pwrseq {
-- 
1.9.1
