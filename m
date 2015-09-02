From: amstan@chromium.org (Alexandru M Stan)
Date: Wed,  2 Sep 2015 15:20:06 -0700
Subject: [PATCH] ARM: dts: rk3288: pull up cts lines
Message-ID: <1441232406-32628-1-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flow control lines from a user accessible UART are optional,
the user might not have anything connected to those pins.
In order to prevent random interrupts happening and noise affecting
that pin it should be pulled up.

Note that the default state for those pins on the rk3288 is pulled up,
so this patch merely restores them.

Suggested-by: Neil Hendin <nhendin@chromium.org>
Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..a059367 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1211,11 +1211,11 @@
 			};
 
 			uart0_cts: uart0-cts {
-				rockchip,pins = <4 18 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <4 18 RK_FUNC_1 &pcfg_pull_up>;
 			};
 
 			uart0_rts: uart0-rts {
-				rockchip,pins = <4 19 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <4 19 RK_FUNC_1 &pcfg_pull_up>;
 			};
 		};
 
@@ -1226,11 +1226,11 @@
 			};
 
 			uart1_cts: uart1-cts {
-				rockchip,pins = <5 10 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <5 10 RK_FUNC_1 &pcfg_pull_up>;
 			};
 
 			uart1_rts: uart1-rts {
-				rockchip,pins = <5 11 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <5 11 RK_FUNC_1 &pcfg_pull_up>;
 			};
 		};
 
@@ -1249,11 +1249,11 @@
 			};
 
 			uart3_cts: uart3-cts {
-				rockchip,pins = <7 9 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <7 9 RK_FUNC_1 &pcfg_pull_up>;
 			};
 
 			uart3_rts: uart3-rts {
-				rockchip,pins = <7 10 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <7 10 RK_FUNC_1 &pcfg_pull_up>;
 			};
 		};
 
@@ -1264,11 +1264,11 @@
 			};
 
 			uart4_cts: uart4-cts {
-				rockchip,pins = <5 14 3 &pcfg_pull_none>;
+				rockchip,pins = <5 14 3 &pcfg_pull_up>;
 			};
 
 			uart4_rts: uart4-rts {
-				rockchip,pins = <5 15 3 &pcfg_pull_none>;
+				rockchip,pins = <5 15 3 &pcfg_pull_up>;
 			};
 		};
 
-- 
2.5.0.457.gab17608
