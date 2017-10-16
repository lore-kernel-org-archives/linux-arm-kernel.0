From: marco.franchi@nxp.com (Marco Franchi)
Date: Mon, 16 Oct 2017 10:48:29 -0200
Subject: [PATCH 5/6] ARM: dts: imx53-qsb-common: Fix 'led_gpio7_7@0' node with
 unit name and no reg property
In-Reply-To: <1508158110-5188-1-git-send-email-marco.franchi@nxp.com>
References: <1508158110-5188-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508158110-5188-5-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 50000000/iomuxc at 53fa8000/
imx53-qsb/led_gpio7_7 at 0 has a unit name, but no reg property

Fix this warning by removing '@0' from such node.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 683dcbe..d214e1f 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -172,7 +172,7 @@
 			>;
 		};
 
-		led_pin_gpio7_7: led_gpio7_7 at 0 {
+		led_pin_gpio7_7: led_gpio7_7 {
 			fsl,pins = <
 				MX53_PAD_PATA_DA_1__GPIO7_7 0x80000000
 			>;
-- 
2.7.4
