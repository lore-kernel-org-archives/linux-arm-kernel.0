From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 18 Oct 2017 17:29:49 -0200
Subject: [PATCH v2 4/6] ARM: dts: imx53-m53evk: Fix 'led_gpio@0' node with
 unit name and no reg property
In-Reply-To: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
References: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508354991-18016-4-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 50000000/iomuxc at 53fa8000/imx53-m53evk/led_gpio at 0 has a unit name, but no reg property

Fix this warning by removing '@0' from such node.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
-none
 arch/arm/boot/dts/imx53-m53evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 9794a04..fdbf525 100644
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
