From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  2 Dec 2015 19:12:20 +0800
Subject: [PATCH 1/2] arm64: dts: rockchip: change the correct voltage range
 for rk3368 evb board
Message-ID: <1449054741-25354-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general, the logic voltage is affected by ddr frequency factors.
We should fix the correct voltage range since assuemd that we have the
ddr frequency driver in mainline.

AFAIK, the 1.8v voltage is used by the SD3.0 card.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts b/arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts
index eed6d3c..8a5275f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts
@@ -104,8 +104,8 @@
 
 			vdd_log: REG3 {
 				regulator-name = "VDD_LOG";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
@@ -118,7 +118,7 @@
 
 			vccio_sd: REG5 {
 				regulator-name = "VCCIO_SD";
-				regulator-min-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
-- 
1.9.1
