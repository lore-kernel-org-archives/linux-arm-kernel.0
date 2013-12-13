From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:40 +0900
Subject: [PATCH 66/69] ARM: shmobile: Use r8a7778 suffix for INTC compat string
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <d79af224b7a7d4d24c1170960eefb48ccb328eff.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-r8a7778" to the compatible string for the
IRQ pins in case of r8a7778 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index b530df6..ddb3bd7 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -43,7 +43,7 @@
 
 	/* irqpin: IRQ0 - IRQ3 */
 	irqpin: irqpin at fe78001c {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7778", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		status = "disabled"; /* default off */
-- 
1.8.4
