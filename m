From: dianders@chromium.org (Douglas Anderson)
Date: Tue, 14 Jun 2016 13:21:11 -0700
Subject: [PATCH] arm64: dts: rockchip: add ap_pwroff and ddrio_pwroff pins for
 rk3399
Message-ID: <1465935671-13890-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two sleep related pins on rk3399: ap_pwroff and ddrio_pwroff.
Let's add the definition of these two pins to rk3399's main dtsi file so
that boards can use them.

These two pins are similar to the global_pwroff and ddrio_pwroff pins in
rk3288 and are expected to be used in the same way: boards will likely
want to configure these pinctrl settings in their global pinctrl hog
list.

Note that on rk3288 there were two additional pins in the "sleep"
section: "ddr0_retention" and "ddr1_retention".  On rk3288 designs these
pins appeared to actually route from rk3288 back to rk3288.  Presumably
on rk3399 this is simply not needed since the pins don't appear to exist
there.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d331e800c00a..209f555b7c29 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -806,6 +806,16 @@
 			};
 		};
 
+		sleep {
+			ap_pwroff: ap-pwroff {
+				rockchip,pins = <1 5 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			ddrio_pwroff: ddrio-pwroff {
+				rockchip,pins = <0 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		spdif {
 			spdif_bus: spdif-bus {
 				rockchip,pins =
-- 
2.8.0.rc3.226.g39d4020
