From: marco.franchi@nxp.com (Marco Franchi)
Date: Mon, 16 Oct 2017 10:48:28 -0200
Subject: [PATCH 4/6] ARM: dts: imx53-m53evk: Fix 'led_gpio@0' node with unit
 name and no reg property
In-Reply-To: <1508158110-5188-1-git-send-email-marco.franchi@nxp.com>
References: <1508158110-5188-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508158110-5188-4-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 50000000/iomuxc at 53fa8000/
imx53-m53evk/led_gpio at 0 has a unit name, but no reg property

Fix this warning by removing '@0' from such node.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 4347a32..c2cefe2 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -183,7 +183,7 @@
 			>;
 		};
 
-		led_pin_gpio: led_gpio at 0 {
+		led_pin_gpio: led_gpio {
 			fsl,pins = <
 				MX53_PAD_PATA_DATA8__GPIO2_8		0x80000000
 				MX53_PAD_PATA_DATA9__GPIO2_9		0x80000000
-- 
2.7.4
