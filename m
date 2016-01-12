From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 12 Jan 2016 22:07:32 +0200
Subject: [PATCH 1/2] ARM: DTS: kirkwood-openrd: fix pin names for UART/SD
 selection
Message-ID: <1452629253-21748-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART/SD pin names are swapped, fix that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/kirkwood-openrd.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
index d3330da..2a3dafd 100644
--- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
+++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
@@ -40,7 +40,7 @@
 			pinctrl-0 = <&pmx_select28 &pmx_sdio_cd &pmx_select34>;
 			pinctrl-names = "default";
 
-			pmx_select28: pmx-select-uart-sd {
+			pmx_select28: pmx-select-rs232-rs484 {
 				marvell,pins = "mpp28";
 				marvell,function = "gpio";
 			};
@@ -48,7 +48,7 @@
 				marvell,pins = "mpp29";
 				marvell,function = "gpio";
 			};
-			pmx_select34: pmx-select-rs232-rs484 {
+			pmx_select34: pmx-select-uart-sd {
 				marvell,pins = "mpp34";
 				marvell,function = "gpio";
 			};
-- 
2.4.0
