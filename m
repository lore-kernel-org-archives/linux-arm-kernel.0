From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:30:42 +0900
Subject: [PATCH 4/6] ARM: shmobile: r8a7778 dtsi: Use "arm,pl390" for GIC
In-Reply-To: <cover.1450401902.git.horms+renesas@verge.net.au>
References: <cover.1450401902.git.horms+renesas@verge.net.au>
Message-ID: <26828d9e943dbc67ef4104eabc869ee407b9be64.1450401902.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4f8e07811746..757c6ff319df 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -61,7 +61,7 @@
 	};
 
 	gic: interrupt-controller at fe438000 {
-		compatible = "arm,cortex-a9-gic";
+		compatible = "arm,pl390";
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0xfe438000 0x1000>,
-- 
2.1.4
