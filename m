From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Oct 2017 11:25:49 +0200
Subject: [PATCH] ARM: dts: rockchip: fix mali400 ppmmu interrupt names
Message-ID: <20171010092549.13895-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupts were wrongly named as ppXmmu while the binding
specifies them as ppmmuX.
Fix that for the recently added Utgard mali nodes on Rockchip socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Already applied for 4.15

 arch/arm/boot/dts/rk3036.dtsi  | 2 +-
 arch/arm/boot/dts/rk3066a.dtsi | 8 ++++----
 arch/arm/boot/dts/rk3188.dtsi  | 8 ++++----
 arch/arm/boot/dts/rk322x.dtsi  | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 5b084c0143ce..3b704cfed69a 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -162,7 +162,7 @@
 		interrupt-names = "gp",
 				  "gpmmu",
 				  "pp0",
-				  "pp0mmu";
+				  "ppmmu0";
 		assigned-clocks = <&cru SCLK_GPU>;
 		assigned-clock-rates = <100000000>;
 		clocks = <&cru SCLK_GPU>, <&cru SCLK_GPU>;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index b76119dd5733..06523caca27d 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -625,13 +625,13 @@
 	interrupt-names = "gp",
 			  "gpmmu",
 			  "pp0",
-			  "pp0mmu",
+			  "ppmmu0",
 			  "pp1",
-			  "pp1mmu",
+			  "ppmmu1",
 			  "pp2",
-			  "pp2mmu",
+			  "ppmmu2",
 			  "pp3",
-			  "pp3mmu";
+			  "ppmmu3";
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 9e24d0ffadac..aa10caae51c3 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -568,13 +568,13 @@
 	interrupt-names = "gp",
 			  "gpmmu",
 			  "pp0",
-			  "pp0mmu",
+			  "ppmmu0",
 			  "pp1",
-			  "pp1mmu",
+			  "ppmmu1",
 			  "pp2",
-			  "pp2mmu",
+			  "ppmmu2",
 			  "pp3",
-			  "pp3mmu";
+			  "ppmmu3";
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index c97287ebb0ea..780ec3a99b21 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -570,9 +570,9 @@
 		interrupt-names = "gp",
 				  "gpmmu",
 				  "pp0",
-				  "pp0mmu",
+				  "ppmmu0",
 				  "pp1",
-				  "pp1mmu";
+				  "ppmmu1";
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
 		clock-names = "core", "bus";
 		resets = <&cru SRST_GPU_A>;
-- 
2.14.1
