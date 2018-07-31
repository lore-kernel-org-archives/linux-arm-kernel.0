From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 31 Jul 2018 18:08:54 +0200
Subject: [PATCH/RFC 3/4] ARM: dts: r8a7779: Add device node for ARM global
 timer
In-Reply-To: <20180731160855.6758-1-geert+renesas@glider.be>
References: <20180731160855.6758-1-geert+renesas@glider.be>
Message-ID: <20180731160855.6758-4-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the global timer, which is part of the Cortex-A9
MPCore.

The global timer can serve as an accurate (4 ns) clock source for
scheduling and delay loops.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 03919714645ae56d..f1c9b2bc542c5be9 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -68,6 +68,14 @@
 		      <0xf0000100 0x100>;
 	};
 
+	timer at f0000200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0xf0000200 0x100>;
+		interrupts = <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&cpg_clocks R8A7779_CLK_ZS>;
+	};
+
 	timer at f0000600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xf0000600 0x20>;
-- 
2.17.1
