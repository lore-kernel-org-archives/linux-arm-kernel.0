From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  2 Dec 2015 19:12:21 +0800
Subject: [PATCH 2/2] ARM: dts: rockchip: change the correct voltage range for
 rk3288 evb board
In-Reply-To: <1449054741-25354-1-git-send-email-wxt@rock-chips.com>
References: <1449054741-25354-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1449054741-25354-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general, the logic voltage is affected by ddr frequency factors.
We should fix the correct voltage range since assuemd that we have the
ddr frequency driver in mainline.

AFAIK, the 1.8v voltage is used by the SD3.0 card.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 arch/arm/boot/dts/rk3288-evb-act8846.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 43949a6..2797f32 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -119,8 +119,8 @@
 
 			vdd_log: REG3 {
 				regulator-name = "VDD_LOG";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
@@ -133,7 +133,7 @@
 
 			vccio_sd: REG5 {
 				regulator-name = "VCCIO_SD";
-				regulator-min-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
-- 
1.9.1
