From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Jan 2017 13:49:20 +0100
Subject: [PATCH 4/4] arm64: dts: r8a7796: Link ARM GIC to clock and clock
 domain
In-Reply-To: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
References: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484657360-13101-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Link the ARM GIC to the INTC-AP module clock, and add it to the SYSC
"always-on" PM Domain, so it can be power managed using that clock.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index eb446d9666213720..6591c76613687b40 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -101,6 +101,9 @@
 			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
 					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 		};
 
 		timer {
-- 
1.9.1
