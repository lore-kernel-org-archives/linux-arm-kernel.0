From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 24 Mar 2016 13:25:21 +0900
Subject: [PATCH v5 12/21] ARM: dts: Add DMC bus node for Exynos3250
In-Reply-To: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1458793530-31897-13-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DMC (Dynamic Memory Controller) bus node for Exynos3250 SoC.
The DMC is an AMBA AXI-compliant slave to interface external JEDEC standard
SDRAM devices. The bus includes the OPP tables and the source clock for DMC
block.

Following list specifies the detailed relation between the clock and DMC block:
- The source clock of DMC block : div_dmc

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 137f9015d4e8..1ae72c4fa55e 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -688,6 +688,40 @@
 			clock-names = "ppmu";
 			status = "disabled";
 		};
+
+		bus_dmc: bus_dmc {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu_dmc CLK_DIV_DMC>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_dmc_opp_table>;
+			status = "disabled";
+		};
+
+		bus_dmc_opp_table: opp_table1 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp at 50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <800000>;
+			};
+			opp at 100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <800000>;
+			};
+			opp at 134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+				opp-microvolt = <800000>;
+			};
+			opp at 200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <825000>;
+			};
+			opp at 400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <875000>;
+			};
+		};
 	};
 };
 
-- 
1.9.1
