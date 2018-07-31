From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 31 Jul 2018 18:08:52 +0200
Subject: [PATCH/RFC 1/4] ARM: dts: sh73a0: Rename twd clock to periph clock
In-Reply-To: <20180731160855.6758-1-geert+renesas@glider.be>
References: <20180731160855.6758-1-geert+renesas@glider.be>
Message-ID: <20180731160855.6758-2-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "TWD" clock is actually the Cortex-A9 MPCore "PERIPHCLK" clock,
which not only clocks the private timers and watchdogs (TWD), but also
the interrupt controller and global timer.

Hence rename it from "twd" to "periph".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index e8f0a07c45645737..b495a9d2f1118006 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -43,7 +43,7 @@
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xf0000600 0x20>;
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
-		clocks = <&twd_clk>;
+		clocks = <&periph_clk>;
 	};
 
 	gic: interrupt-controller at f0001000 {
@@ -812,7 +812,7 @@
 			clock-div = <13>;
 			clock-mult = <1>;
 		};
-		twd_clk: twd {
+		periph_clk: periph {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks SH73A0_CLK_Z>;
 			#clock-cells = <0>;
-- 
2.17.1
