From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:54:43 -0200
Subject: [PATCH v2 10/11] ARM: dts: imx6sx: Fix spba-bus unit address
In-Reply-To: <1511981684-13433-1-git-send-email-festevam@gmail.com>
References: <1511981684-13433-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981684-13433-10-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The correct unit address for spba-bus is 0x2240000, so change it
accordingly in order to fix the following build warning with W=1:

arch/arm/boot/dts/imx6sx-sabreauto.dtb: Warning (simple_bus_reg): Node /soc/aips-bus at 2200000/spba-bus at 2200000 simple-bus unit address format error, expected "2240000"

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 07ba518..5a5f796 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1150,7 +1150,7 @@
 			reg = <0x02200000 0x100000>;
 			ranges;
 
-			spba-bus at 2200000 {
+			spba-bus at 2240000 {
 				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.7.4
