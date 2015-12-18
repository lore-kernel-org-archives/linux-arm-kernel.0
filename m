From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:30:41 +0900
Subject: [PATCH 3/6] ARM: shmobile: emev2 dtsi: Use "arm,pl390" for GIC
In-Reply-To: <cover.1450401902.git.horms+renesas@verge.net.au>
References: <cover.1450401902.git.horms+renesas@verge.net.au>
Message-ID: <c8a5880afeb8f14c8338e90e7b7c4c597a6f7e0b.1450401902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace the "arm,cortex-a9-gic" compatible value for the GIC by
"arm,pl390", as the documentation states it is a PL390.
This has been confirmed (thanks Simon!) by reading the GICD_IIDR
register, which reports 0x0000043b (PL390 = 0x00, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index edad0c4eea35..57795da616cb 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -44,7 +44,7 @@
 	};
 
 	gic: interrupt-controller at e0020000 {
-		compatible = "arm,cortex-a9-gic";
+		compatible = "arm,pl390";
 		interrupt-controller;
 		#interrupt-cells = <3>;
 		reg = <0xe0028000 0x1000>,
-- 
2.1.4
