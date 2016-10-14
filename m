From: paweljarosz3691@gmail.com (=?utf-8?B?UGF3ZcWC?= Jarosz)
Date: Fri, 14 Oct 2016 14:16:54 +0200
Subject: [PATCH v2 2/2] ARM: dts: rockchip: initialize rk3066 PLL clock rate
In-Reply-To: <cover.1476447057.git.paweljarosz3691@gmail.com>
References: <cover.1476447057.git.paweljarosz3691@gmail.com>
Message-ID: <6992e44d06e1615048717deb3dd76e52d26da869.1476447057.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize PLL, cpu bus and peripherial bus rate while kernel init.
No other module does than.

This gives us performance boost observable for example in mmc transfers.

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---

Changes in v2:
- added peripherial and cpu bus
- removed PLL_DPLL, PLL_APLL

 arch/arm/boot/dts/rk3066a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 0d0dae3..29dd434 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -151,6 +151,15 @@
 
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		assigned-clocks = <&cru PLL_CPLL>, <&cru PLL_GPLL>,
+				  <&cru ACLK_CPU>, <&cru HCLK_CPU>,
+				  <&cru PCLK_CPU>, <&cru ACLK_PERI>,
+				  <&cru HCLK_PERI>, <&cru PCLK_PERI>;
+
+		assigned-clock-rates = <400000000>, <594000000>,
+				       <300000000>, <150000000>,
+				       <75000000>, <300000000>,
+				       <150000000>, <75000000>;
 	};
 
 	timer at 2000e000 {
-- 
2.7.4
