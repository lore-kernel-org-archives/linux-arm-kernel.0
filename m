From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  4 May 2018 02:38:45 +0800
Subject: [PATCH 5/7] arm64: allwinner: h6: add R_INTC interrupt controller
In-Reply-To: <20180503183847.11046-1-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
Message-ID: <20180503183847.11046-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 SoC has also a R_INTC interrupt controller like Allwinner
A64 SoC, but has its base address changed due to the memory map change
in H6.

Add it into the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index a18b78fb4850..b0b342c8c189 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -184,6 +184,15 @@
 			#reset-cells = <1>;
 		};
 
+		r_intc: interrupt-controller at 7021000 {
+			compatible = "allwinner,sun50i-h6-r-intc",
+				     "allwinner,sun6i-a31-r-intc";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x07021000 0x400>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_pio: pinctrl at 7022000 {
 			compatible = "allwinner,sun50i-h6-r-pinctrl";
 			reg = <0x07022000 0x400>;
-- 
2.15.1
