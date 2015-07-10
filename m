From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:19 +0900
Subject: [PATCH 11/11] ARM: shmobile: r8a7779: Configure IRLM mode via DT
In-Reply-To: <cover.1436509954.git.horms+renesas@verge.net.au>
References: <cover.1436509954.git.horms+renesas@verge.net.au>
Message-ID: <7bf46d0be278a3586c78322c65ceff5fd03bb95d.1436509954.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7779 SoC DTS and the Marzen Reference
C board code to use DTS only for INTC-IRQPIN IRLM setup.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5c8071e87ae9..a2b5430d3257 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -148,7 +148,7 @@
 		interrupt-controller;
 	};
 
-	irqpin0: interrupt-controller at fe780010 {
+	irqpin0: interrupt-controller at fe78001c {
 		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		status = "disabled";
@@ -157,7 +157,8 @@
 			<0xfe780010 4>,
 			<0xfe780024 4>,
 			<0xfe780044 4>,
-			<0xfe780064 4>;
+			<0xfe780064 4>,
+			<0xfe780000 4>;
 		interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH
 			      0 28 IRQ_TYPE_LEVEL_HIGH
 			      0 29 IRQ_TYPE_LEVEL_HIGH
-- 
2.1.4
