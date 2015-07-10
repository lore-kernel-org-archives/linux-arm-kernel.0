From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:14 +0900
Subject: [PATCH 06/11] ARM: shmobile: r8a73a4 dtsi: Use "arm,gic-400" for GIC
In-Reply-To: <cover.1436509954.git.horms+renesas@verge.net.au>
References: <cover.1436509954.git.horms+renesas@verge.net.au>
Message-ID: <eaec1d675c194965081297014503938a9f58e2f7.1436509954.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace the "arm,cortex-a15-gic" compatible value for the GIC by
"arm,gic-400", as the documentation states it's a GIC-400.
This has been confirmed by reading the GICD_IIDR register, which reports
0x0200043b (GIC-400 = 0x02, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 7ee22a41c6c9..5090d1a8f652 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -434,7 +434,7 @@
 	};
 
 	gic: interrupt-controller at f1001000 {
-		compatible = "arm,cortex-a15-gic";
+		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
-- 
2.1.4
