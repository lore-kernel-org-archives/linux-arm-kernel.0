From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:05 +0100
Subject: [PATCH 27/37] ARM: dts: r8a7740: Correct TPU register block size
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <2211a3062c8dd3d8081ac208240ab48d7786f353.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Timer Pulse Unit has registers that lie outside the declared
register block.  Enlarge the register block size to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 95c408b11991..afd3bc5e6cf2 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -317,7 +317,7 @@
 
 	tpu: pwm at e6600000 {
 		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
-		reg = <0xe6600000 0x100>;
+		reg = <0xe6600000 0x148>;
 		clocks = <&mstp3_clks R8A7740_CLK_TPU0>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
-- 
2.11.0
