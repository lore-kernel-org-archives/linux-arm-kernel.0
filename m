From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  1 Dec 2017 17:24:35 -0200
Subject: [PATCH 02/12] ARM: dts: imx51-zii-rdu1: Add the unit addresses in
 sysled
In-Reply-To: <1512156285-18451-1-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
Message-ID: <1512156285-18451-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As described at Documentation/devicetree/bindings/mfd/mc13xxx.txt the
reg property is mandatory, so add the corresponding unit address in
order to fix the following build warnings with W=1:

arch/arm/boot/dts/imx51-zii-rdu1.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
arch/arm/boot/dts/imx51-zii-rdu1.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 70000000/spba at 70000000/ecspi at 70010000/pmic at 0/leds/sysled0 has a reg or ranges property, but no unit name
arch/arm/boot/dts/imx51-zii-rdu1.dtb: Warning (unit_address_vs_reg): Node /soc/aips at 70000000/spba at 70000000/ecspi at 70010000/pmic at 0/leds/sysled1 has a reg or ranges property, but no unit name

Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index f9fdb7c..70fdcdd 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -428,13 +428,13 @@
 			#size-cells = <0>;
 			led-control = <0x0 0x0 0x3f83f8 0x0>;
 
-			sysled0 {
+			sysled0 at 3 {
 				reg = <3>;
 				label = "system:green:status";
 				linux,default-trigger = "default-on";
 			};
 
-			sysled1 {
+			sysled1 at 4 {
 				reg = <4>;
 				label = "system:green:act";
 				linux,default-trigger = "heartbeat";
-- 
2.7.4
