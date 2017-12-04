From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Dec 2017 10:20:07 -0200
Subject: [PATCH v2 03/12] ARM: dts: imx53-m53: Remove unneeded reg property
In-Reply-To: <1512390016-703-1-git-send-email-festevam@gmail.com>
References: <1512390016-703-1-git-send-email-festevam@gmail.com>
Message-ID: <1512390016-703-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As described in
Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
there is no 'reg' property under stmpe_touchscreen, so remove it
to fix the following build warning with W=1:

arch/arm/boot/dts/imx53-m53evk.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 60000000/i2c at 63fc4000/stmpe610 at 41/stmpe_touchscreen has a reg or ranges property, but no unit name

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx53-m53.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/imx53-m53.dtsi
index ec390aa5..7ce69c6 100644
--- a/arch/arm/boot/dts/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/imx53-m53.dtsi
@@ -64,7 +64,6 @@
 
 		stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
-			reg = <0>;
 			st,sample-time = <4>;
 			st,mod-12b = <1>;
 			st,ref-sel = <0>;
-- 
2.7.4
