From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  4 May 2018 02:38:44 +0800
Subject: [PATCH 4/7] arm64: allwinner: h6: add node for R_PIO pin controller
In-Reply-To: <20180503183847.11046-1-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
Message-ID: <20180503183847.11046-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 SoC has a R_PIO pin controller which controls PL and PM
GPIO banks.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index db9da343ba46..a18b78fb4850 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -183,5 +183,18 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		r_pio: pinctrl at 7022000 {
+			compatible = "allwinner,sun50i-h6-r-pinctrl";
+			reg = <0x07022000 0x400>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
 	};
 };
-- 
2.15.1
