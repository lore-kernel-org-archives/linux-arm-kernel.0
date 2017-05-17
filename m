From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 12:45:20 +0800
Subject: [PATCH 1/4] arm: dts: rk322x: add some assigned-clocks
In-Reply-To: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
References: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1494996323-4678-2-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add CPLL, GPLL and some other assigned-clocks for rk322x SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 221251a..40044e8 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -346,8 +346,18 @@
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-		assigned-clocks = <&cru PLL_GPLL>;
-		assigned-clock-rates = <594000000>;
+		assigned-clocks =
+			<&cru PLL_GPLL>, <&cru ARMCLK>,
+			<&cru PLL_CPLL>, <&cru ACLK_PERI>,
+			<&cru HCLK_PERI>, <&cru PCLK_PERI>,
+			<&cru ACLK_CPU>, <&cru HCLK_CPU>,
+			<&cru PCLK_CPU>;
+		assigned-clock-rates =
+			<594000000>, <816000000>,
+			<500000000>, <150000000>,
+			<150000000>, <75000000>,
+			<150000000>, <150000000>,
+			<75000000>;
 	};
 
 	thermal-zones {
-- 
2.0.0
