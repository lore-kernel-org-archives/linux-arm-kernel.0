From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 29 May 2015 12:04:13 -0400
Subject: [PATCH 2/2] ARM: dts: keystone: fix dt bindings to use post div
 register for mainpll
In-Reply-To: <1432915453-409-1-git-send-email-m-karicheri2@ti.com>
References: <1432915453-409-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1432915453-409-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of the keystone devices have a separate register to hold post
divider value for main pll clock. Currently the fixed-postdiv
value used for k2hk/l/e SoCs works by sheer luck as u-boot happens to
use a value of 2 for this. Now that we have fixed this in the pll
clock driver change the dt bindings for the same.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/k2e-clocks.dtsi  | 5 ++---
 arch/arm/boot/dts/k2hk-clocks.dtsi | 5 ++---
 arch/arm/boot/dts/k2l-clocks.dtsi  | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/k2e-clocks.dtsi b/arch/arm/boot/dts/k2e-clocks.dtsi
index 4773d6a..d56d68f 100644
--- a/arch/arm/boot/dts/k2e-clocks.dtsi
+++ b/arch/arm/boot/dts/k2e-clocks.dtsi
@@ -13,9 +13,8 @@ clocks {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,main-pll-clock";
 		clocks = <&refclksys>;
-		reg = <0x02620350 4>, <0x02310110 4>;
-		reg-names = "control", "multiplier";
-		fixed-postdiv = <2>;
+		reg = <0x02620350 4>, <0x02310110 4>, <0x02310108 4>;
+		reg-names = "control", "multiplier", "post-divider";
 	};
 
 	papllclk: papllclk at 2620358 {
diff --git a/arch/arm/boot/dts/k2hk-clocks.dtsi b/arch/arm/boot/dts/k2hk-clocks.dtsi
index d5adee3..af9b719 100644
--- a/arch/arm/boot/dts/k2hk-clocks.dtsi
+++ b/arch/arm/boot/dts/k2hk-clocks.dtsi
@@ -22,9 +22,8 @@ clocks {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,main-pll-clock";
 		clocks = <&refclksys>;
-		reg = <0x02620350 4>, <0x02310110 4>;
-		reg-names = "control", "multiplier";
-		fixed-postdiv = <2>;
+		reg = <0x02620350 4>, <0x02310110 4>, <0x02310108 4>;
+		reg-names = "control", "multiplier", "post-divider";
 	};
 
 	papllclk: papllclk at 2620358 {
diff --git a/arch/arm/boot/dts/k2l-clocks.dtsi b/arch/arm/boot/dts/k2l-clocks.dtsi
index eb1e3e2..ef8464b 100644
--- a/arch/arm/boot/dts/k2l-clocks.dtsi
+++ b/arch/arm/boot/dts/k2l-clocks.dtsi
@@ -22,9 +22,8 @@ clocks {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,main-pll-clock";
 		clocks = <&refclksys>;
-		reg = <0x02620350 4>, <0x02310110 4>;
-		reg-names = "control", "multiplier";
-		fixed-postdiv = <2>;
+		reg = <0x02620350 4>, <0x02310110 4>, <0x02310108 4>;
+		reg-names = "control", "multiplier", "post-divider";
 	};
 
 	papllclk: papllclk at 2620358 {
-- 
1.9.1
