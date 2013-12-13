From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:41 +0900
Subject: [PATCH 67/69] ARM: shmobile: Use r8a7779 suffix for INTC compat string
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <11ef0340a8cdf9db9a5c49298f361258d090fefb.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-r8a7779" to the compatible string for the
IRQ pins in case of r8a7779 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index b2b418a..8284715 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -135,7 +135,7 @@
 	};
 
 	irqpin0: irqpin at fe780010 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		status = "disabled";
 		interrupt-controller;
-- 
1.8.4
