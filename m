From: paweljarosz3691@gmail.com (=?utf-8?B?UGF3ZcWC?= Jarosz)
Date: Thu, 6 Oct 2016 21:42:21 +0200
Subject: [PATCH] ARM: dts: rockchip: initialize rk3066 PLL clock rate
Message-ID: <20161006194221.GA4895@vaio-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize PLL rate while kernel init. No other module does than.
Clock rates are taken from rk3066 TRM. Assigned values are for 125 degrees
celcius operating point.
This gives us performance boost observable for example in mmc transfers.

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 0d0dae3..cf215e8 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -151,6 +151,10 @@
 
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		assigned-clocks = <&cru PLL_DPLL>, <&cru PLL_APLL>,
+				  <&cru PLL_CPLL>, <&cru PLL_GPLL>;
+		assigned-clock-rates = <533000000>, <600000000>,
+				       <600000000>, <600000000>;
 	};
 
 	timer at 2000e000 {
-- 
2.7.4
