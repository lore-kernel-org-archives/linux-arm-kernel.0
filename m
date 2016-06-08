From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:42 +0900
Subject: [PATCH 12/30] ARM: dts: r8a7740: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <28c8c0aa095360ec14c3bcbe7f3ed378faf1daac.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /cache-controller has a reg or ranges property, but no unit name

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 39b2f88ad151..159e04eb1b9e 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -39,7 +39,7 @@
 		      <0xc2000000 0x1000>;
 	};
 
-	L2: cache-controller {
+	L2: cache-controller at f0100000 {
 		compatible = "arm,pl310-cache";
 		reg = <0xf0100000 0x1000>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
