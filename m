From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:30:40 +0900
Subject: [PATCH 2/6] ARM: shmobile: r8a7740 dtsi: Use "arm,pl390" for GIC
In-Reply-To: <cover.1450401902.git.horms+renesas@verge.net.au>
References: <cover.1450401902.git.horms+renesas@verge.net.au>
Message-ID: <ad14ba96f962a44df0a6d5645beed7d2f776bdfa.1450401902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace the "arm,cortex-a9-gic" compatible value for the GIC by
"arm,pl390", as the documentation states it is a PL390.
This has been confirmed by reading the GICD_IIDR register, which reports
0x0000043b (PL390 = 0x00, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index e14cb1438216..20d20f67620b 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -30,7 +30,7 @@
 	};
 
 	gic: interrupt-controller at c2800000 {
-		compatible = "arm,cortex-a9-gic";
+		compatible = "arm,pl390";
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0xc2800000 0x1000>,
-- 
2.1.4
