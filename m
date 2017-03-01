From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  1 Mar 2017 12:15:41 +0800
Subject: [PATCH 3/3] arm64: dts: allwinner: add r_ccu node
In-Reply-To: <20170301041541.24388-1-icenowy@aosc.xyz>
References: <20170301041541.24388-1-icenowy@aosc.xyz>
Message-ID: <20170301041541.24388-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A64 SoC have a CCU (r_ccu) in PRCM block.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1c64ea2d23f9..e8be100b91a0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -43,8 +43,10 @@
  */
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
+#include <dt-bindings/clock/sun6i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
+#include <dt-bindings/reset/sun6i-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -392,5 +394,14 @@
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		r_ccu: clock at 1f01400 {
+			compatible = "allwinner,sun50i-a64-r-ccu";
+			reg = <0x01cf01400 0x100>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.11.1
