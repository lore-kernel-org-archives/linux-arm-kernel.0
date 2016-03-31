From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 31 Mar 2016 18:05:58 +0900
Subject: [PATCH v7 13/20] ARM: dts: Add bus nodes using VDD_INT for Exynos3250
In-Reply-To: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1459415165-32613-14-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the bus nodes using VDD_INT for Exynos3250 SoC.
Exynos3250 has following AXI buses to translate data between
DRAM and sub-blocks.

Following list specifies the detailed relation between DRAM and sub-blocks:
- ACLK400 clock for MCUISP
- ACLK266 clock for ISP
- ACLK200 clock for FSYS
- ACLK160 clock for LCD0
- ACLK100 clock for PERIL
- GDL clock for LEFTBUS
- GDR clock for RIGHTBUS
- SCLK_MFC clock for MFC

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 147 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 1ae72c4fa55e..b5157492a422 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -722,6 +722,153 @@
 				opp-microvolt = <875000>;
 			};
 		};
+
+		bus_leftbus: bus_leftbus {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_GDL>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_rightbus: bus_rightbus {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_GDR>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_lcd0: bus_lcd0 {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_160>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_fsys: bus_fsys {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_200>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_mcuisp: bus_mcuisp {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_mcuisp_opp_table>;
+			status = "disabled";
+		};
+
+		bus_isp: bus_isp {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_266>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_isp_opp_table>;
+			status = "disabled";
+		};
+
+		bus_peril: bus_peril {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_100>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_peril_opp_table>;
+			status = "disabled";
+		};
+
+		bus_mfc: bus_mfc {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_SCLK_MFC>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_leftbus_opp_table: opp_table2 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp at 50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <900000>;
+			};
+			opp at 80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+				opp-microvolt = <900000>;
+			};
+			opp at 100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp at 134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp at 200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <1000000>;
+			};
+		};
+
+		bus_mcuisp_opp_table: opp_table3 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp at 50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp at 80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp at 100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp at 200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+			opp at 400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+			};
+		};
+
+		bus_isp_opp_table: opp_table4 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp at 50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp at 80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp at 100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp at 200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+			opp at 300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+			};
+		};
+
+		bus_peril_opp_table: opp_table5 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp at 50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp at 80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp at 100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+		};
 	};
 };
 
-- 
1.9.1
