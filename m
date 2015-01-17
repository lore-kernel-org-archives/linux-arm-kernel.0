From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:58:43 +0900
Subject: [PATCH 10/11] ARM: shmobile: sh73a0 dtsi: Add memory-controller nodes
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
Message-ID: <29828c87560dbdb567e759e4e6bb4ad0febfcf21.1421380713.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add device nodes for the two SDRAM Bus State Controllers.
The SBSCs are located in the A4BC0 resp. A4BC1 PM domains, which must
not be powered down, else the system will crash.

References to the A4BC0 and A4BC1 PM domains will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index d4cfb06..37c8a76 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -42,6 +42,22 @@
 		      <0xf0000100 0x100>;
 	};
 
+	sbsc2: memory-controller at fb400000 {
+		compatible = "renesas,sbsc-sh73a0";
+		reg = <0xfb400000 0x400>;
+		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sec", "temp";
+	};
+
+	sbsc1: memory-controller at fe400000 {
+		compatible = "renesas,sbsc-sh73a0";
+		reg = <0xfe400000 0x400>;
+		interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 36 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sec", "temp";
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.1.4
