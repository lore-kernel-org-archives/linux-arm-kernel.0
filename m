From: max.schwarz@online.de (Max Schwarz)
Date: Sun, 09 Mar 2014 20:43:11 +0100
Subject: [PATCH] ARM: rockchip: rk3188: enable pull-ups on UART inputs
Message-ID: <6599423.XddAUl3dCe@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable integrated pull-ups on the UART RX pins of Rockchip RK3188.

This fixes UART receive on the radxa Rock board, which has an input diode
preventing the RX pin from being raised from the outside.

Signed-off-by: Max Schwarz <max.schwarz@online.de>
---
 arch/arm/boot/dts/rk3188.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 412f4d0..2e10bd7 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -149,7 +149,7 @@
 
 			uart0 {
 				uart0_xfer: uart0-xfer {
-					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_none>,
+					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
 							<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_none>;
 				};
 
@@ -164,7 +164,7 @@
 
 			uart1 {
 				uart1_xfer: uart1-xfer {
-					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_none>,
+					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_up>,
 							<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_none>;
 				};
 
@@ -179,7 +179,7 @@
 
 			uart2 {
 				uart2_xfer: uart2-xfer {
-					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_none>,
+					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_up>,
 							<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_none>;
 				};
 				/* no rts / cts for uart2 */
@@ -187,7 +187,7 @@
 
 			uart3 {
 				uart3_xfer: uart3-xfer {
-					rockchip,pins = <RK_GPIO1 10 RK_FUNC_1 &pcfg_pull_none>,
+					rockchip,pins = <RK_GPIO1 10 RK_FUNC_1 &pcfg_pull_up>,
 							<RK_GPIO1 11 RK_FUNC_1 &pcfg_pull_none>;
 				};
 
-- 
1.8.3.2
