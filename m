From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 17:10:12 +0100
Subject: [PATCH] ARM: dts: Update exynos5250-spring with mmc node changes
Message-ID: <1424275812-6797-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resolve a merge conflict with mmc refactoring aaa25a5a33cb ("ARM: dts:
unuse the slot-node and deprecate the supports-highspeed for dw-mmc in
exynos") by dropping the slot at 0 nodes, moving its bus-width property to
the mmc node and replacing supports-highspeed with cap-{mmc,sd}-highspeed,
matching exynos5250-snow.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Fixes: 53dd4138bb0a ("ARM: dts: Add exynos5250-spring device tree")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index f02775487cd4..c41600e587e0 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -429,7 +429,6 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -437,11 +436,8 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
-
-	slot at 0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
+	cap-mmc-highspeed;
 };
 
 /*
@@ -451,7 +447,6 @@
 &mmc_1 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -459,11 +454,8 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_cd &sd1_bus4>;
-
-	slot at 0 {
-		reg = <0>;
-		bus-width = <4>;
-	};
+	bus-width = <4>;
+	cap-sd-highspeed;
 };
 
 &pinctrl_0 {
-- 
2.1.4
