From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:50 +0900
Subject: [PATCH 19/30] ARM: shmobile: r8a7779: Add TWD device to DTS
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <cea806542f6d7ec40eea1c5f9db2065996f56627.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Now when r8a7779 CCF is in place we can hook up
the ARM Cortex-A9 TWD timer via DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d9e1abf..5c2219b 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -12,6 +12,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/clock/r8a7779-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -62,6 +63,14 @@
 		      <0xf0000100 0x100>;
 	};
 
+	timer at f0000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0xf0000600 0x20>;
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&cpg_clocks R8A7779_CLK_ZS>;
+	};
+
 	gpio0: gpio at ffc40000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc40000 0x2c>;
-- 
2.1.3
