From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Jan 2017 10:14:27 +0100
Subject: [PATCH 5/9] arm64: dts: r8a7795: Link ARM GIC to clock and clock
 domain
In-Reply-To: <cover.1485508214.git.horms+renesas@verge.net.au>
References: <cover.1485508214.git.horms+renesas@verge.net.au>
Message-ID: <b6e56e4c1fd747028437956f48832452462ef407.1485508214.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Link the ARM GIC to the INTC-AP module clock, and add it to the SYSC
"always-on" PM Domain, so it can be power managed using that clock.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index d36783e751af..8b030c323c10 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -166,6 +166,9 @@
 			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
 					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		wdt0: watchdog at e6020000 {
-- 
2.7.0.rc3.207.g0ac5344
