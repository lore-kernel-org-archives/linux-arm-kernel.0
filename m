From: romain.perier@collabora.com (Romain Perier)
Date: Thu, 10 Aug 2017 13:46:25 +0200
Subject: [PATCH] ARM: dts: rockchip: set PLLs and core clocks rates for RK3188
Message-ID: <20170810114625.28823-1-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, rates for PLLs or core peri clocks are not set to a specific
rate when booting the kernel. Depending on the previously used
bootloader the state of the clk tree can be good or not.

This commits set PLLs and core clocks rates by using the
assigned-clocks property in CRU (like for RK3288)

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 1399bc04ea77..de6bde651cc2 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -160,6 +160,17 @@
 
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		assigned-clocks = <&cru PLL_GPLL>, <&cru PLL_DPLL>,
+				  <&cru PLL_CPLL>, <&cru PLL_APLL>,
+				  <&cru ACLK_CPU>, <&cru HCLK_CPU>,
+				  <&cru PCLK_CPU>, <&cru ACLK_PERI>,
+				  <&cru HCLK_PERI>, <&cru PCLK_PERI>;
+
+		assigned-clock-rates = <891000000>, <300000000>,
+				       <132000000>, <312000000>,
+				       <148500000>, <148500000>,
+				       <74250000>, <127285715>,
+				       <127285715>, <63642858>;
 	};
 
 	efuse: efuse at 20010000 {
-- 
2.11.0
