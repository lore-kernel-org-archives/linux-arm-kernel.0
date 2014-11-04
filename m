From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:40 +0900
Subject: [PATCH 10/34] ARM: shmobile: r8a7740 dtsi: Fix clock index for scifa2
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <b345aee4d7c2387f2e36cdeb64e0f4dce34598f3.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The clocks property for the scifa2 device node referred to the scifa0
clock index instead of the scifa2 clock index.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 502483f..559bd39 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -197,7 +197,7 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7740_CLK_SCIFA0>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
-- 
2.1.1
