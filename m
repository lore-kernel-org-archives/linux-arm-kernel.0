From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jan 2017 16:11:19 +0100
Subject: [PATCH 2/3] ARM: dts: add the AB8500 sysclk to the device trees
Message-ID: <20170113151119.31662-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock has been missing since some early stages of device tree
conversion. Adding the right clocks to the device tree makes USB
work again.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi  | 2 ++
 arch/arm/boot/dts/ste-href.dtsi    | 2 ++
 arch/arm/boot/dts/ste-snowball.dts | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index d309314f3a36..82d8c4771293 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -669,6 +669,8 @@
 					vddulpivio18-supply = <&ab8500_ldo_intcore_reg>;
 					v-ape-supply = <&db8500_vape_reg>;
 					musb_1v8-supply = <&db8500_vsmps2_reg>;
+					clocks = <&prcmu_clk PRCMU_SYSCLK>;
+					clock-names = "sysclk";
 				};
 
 				ab8500-ponkey {
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 965fa10d1e8a..4f70088d3c8a 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -191,6 +191,8 @@
 
 			stericsson,cpu-dai = <&msp1 &msp3>;
 			stericsson,audio-codec = <&codec>;
+			clocks = <&prcmu_clk PRCMU_SYSCLK>;
+			clock-names = "sysclk";
 		};
 
 		msp0: msp at 80123000 {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 71daa27bb7e3..c6bcc8e2f29a 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -164,6 +164,8 @@
 
 			stericsson,cpu-dai = <&msp1 &msp3>;
 			stericsson,audio-codec = <&codec>;
+			clocks = <&prcmu_clk PRCMU_SYSCLK>;
+			clock-names = "sysclk";
 		};
 
 		msp0: msp at 80123000 {
-- 
2.9.3
