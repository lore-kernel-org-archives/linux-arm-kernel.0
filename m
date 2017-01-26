From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 11:11:05 +0100
Subject: [PATCH 3/7] ARM: dts: r8a7745: Link ARM GIC to clock and clock domain
In-Reply-To: <cover.1485425227.git.horms+renesas@verge.net.au>
References: <cover.1485425227.git.horms+renesas@verge.net.au>
Message-ID: <db017f399639f68827edc954205803272ef20b24.1485425227.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Link the ARM GIC to the INTC-SYS module clock, and add it to the SYSC
"always-on" PM Domain, so it can be power managed using that clock.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 2f60c3cb9117..a81dcc82e2ea 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -60,6 +60,9 @@
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
 						 IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
 		};
 
 		irqc: interrupt-controller at e61c0000 {
-- 
2.7.0.rc3.207.g0ac5344
