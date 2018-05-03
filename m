From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  4 May 2018 02:38:42 +0800
Subject: [PATCH 2/7] arm64: allwinner: h6: add PRCM CCU device node
In-Reply-To: <20180503183847.11046-1-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
Message-ID: <20180503183847.11046-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 has also a PRCM CCU.

Add its device node into the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 4debc3962830..db9da343ba46 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -173,5 +173,15 @@
 			resets = <&ccu RST_BUS_UART3>;
 			status = "disabled";
 		};
+
+		r_ccu: clock at 7010000 {
+			compatible = "allwinner,sun50i-h6-r-ccu";
+			reg = <0x07010000 0x400>;
+			clocks = <&osc24M>, <&osc32k>, <&iosc>,
+				 <&ccu CLK_PLL_PERIPH0>;
+			clock-names = "hosc", "losc", "iosc", "pll-periph";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.15.1
