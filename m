From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 17 Dec 2015 22:21:47 +0800
Subject: [PATCH v1 1/6] ARM: dts: fix the correct pinctrl control for rk3036
In-Reply-To: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
References: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450362112-8075-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl gpio pull up/down is incorrect since the rk3036 SoCs
can't set the status in the internal.

We should keep the default status for enable the gpio status,
In fact, the pull_none is the disable the gpio pull up/down.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3036.dtsi | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index f8758bf..620e6e0 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -427,12 +427,8 @@
 			#interrupt-cells = <2>;
 		};
 
-		pcfg_pull_up: pcfg-pull-up {
-			bias-pull-up;
-		};
-
-		pcfg_pull_down: pcfg-pull-down {
-			bias-pull-down;
+		pcfg_pull_default: pcfg_pull_default {
+			bias-pull-pin-default;
 		};
 
 		pcfg_pull_none: pcfg-pull-none {
@@ -473,18 +469,18 @@
 			};
 
 			emmc_cmd: emmc-cmd {
-				rockchip,pins = <2 1 RK_FUNC_2 &pcfg_pull_none>;
+				rockchip,pins = <2 1 RK_FUNC_2 &pcfg_pull_default>;
 			};
 
 			emmc_bus8: emmc-bus8 {
-				rockchip,pins = <1 24 RK_FUNC_2 &pcfg_pull_none>,
-						<1 25 RK_FUNC_2 &pcfg_pull_none>,
-						<1 26 RK_FUNC_2 &pcfg_pull_none>,
-						<1 27 RK_FUNC_2 &pcfg_pull_none>,
-						<1 28 RK_FUNC_2 &pcfg_pull_none>,
-						<1 29 RK_FUNC_2 &pcfg_pull_none>,
-						<1 30 RK_FUNC_2 &pcfg_pull_none>,
-						<1 31 RK_FUNC_2 &pcfg_pull_none>;
+				rockchip,pins = <1 24 RK_FUNC_2 &pcfg_pull_default>,
+						<1 25 RK_FUNC_2 &pcfg_pull_default>,
+						<1 26 RK_FUNC_2 &pcfg_pull_default>,
+						<1 27 RK_FUNC_2 &pcfg_pull_default>,
+						<1 28 RK_FUNC_2 &pcfg_pull_default>,
+						<1 29 RK_FUNC_2 &pcfg_pull_default>,
+						<1 30 RK_FUNC_2 &pcfg_pull_default>,
+						<1 31 RK_FUNC_2 &pcfg_pull_default>;
 			};
 		};
 
@@ -522,12 +518,12 @@
 
 		uart0 {
 			uart0_xfer: uart0-xfer {
-				rockchip,pins = <0 16 RK_FUNC_1 &pcfg_pull_up>,
+				rockchip,pins = <0 16 RK_FUNC_1 &pcfg_pull_default>,
 						<0 17 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			uart0_cts: uart0-cts {
-				rockchip,pins = <0 18 RK_FUNC_1 &pcfg_pull_up>;
+				rockchip,pins = <0 18 RK_FUNC_1 &pcfg_pull_default>;
 			};
 
 			uart0_rts: uart0-rts {
@@ -537,7 +533,7 @@
 
 		uart1 {
 			uart1_xfer: uart1-xfer {
-				rockchip,pins = <2 22 RK_FUNC_1 &pcfg_pull_none>,
+				rockchip,pins = <2 22 RK_FUNC_1 &pcfg_pull_default>,
 						<2 23 RK_FUNC_1 &pcfg_pull_none>;
 			};
 			/* no rts / cts for uart1 */
@@ -545,7 +541,7 @@
 
 		uart2 {
 			uart2_xfer: uart2-xfer {
-				rockchip,pins = <1 18 RK_FUNC_2 &pcfg_pull_none>,
+				rockchip,pins = <1 18 RK_FUNC_2 &pcfg_pull_default>,
 						<1 19 RK_FUNC_2 &pcfg_pull_none>;
 			};
 			/* no rts / cts for uart2 */
-- 
1.9.1
