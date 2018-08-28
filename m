From: urjaman@gmail.com (Urja Rannikko)
Date: Tue, 28 Aug 2018 18:55:12 +0000
Subject: [PATCH 6/7] dts: rk3288: support for dedicating npll to a vop
In-Reply-To: <20180828185513.13216-1-urjaman@gmail.com>
References: <20180828185513.13216-1-urjaman@gmail.com>
Message-ID: <20180828185513.13216-7-urjaman@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the VOP DCLKs to the assigned clocks list so their
parents can be set in the dts include files for
devices that do dedicate npll to a vop.

Signed-off-by: Urja Rannikko <urjaman@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index d7e49d29ace5..2106ddfdaf06 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -840,12 +840,14 @@
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-		assigned-clocks = <&cru PLL_GPLL>, <&cru PLL_CPLL>,
+		assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>,
+				  <&cru PLL_GPLL>, <&cru PLL_CPLL>,
 				  <&cru PLL_NPLL>, <&cru ACLK_CPU>,
 				  <&cru HCLK_CPU>, <&cru PCLK_CPU>,
 				  <&cru ACLK_PERI>, <&cru HCLK_PERI>,
 				  <&cru PCLK_PERI>;
-		assigned-clock-rates = <594000000>, <400000000>,
+		assigned-clock-rates = <0>, <0>,
+				       <594000000>, <400000000>,
 				       <500000000>, <300000000>,
 				       <150000000>, <75000000>,
 				       <300000000>, <150000000>,
-- 
2.18.0
