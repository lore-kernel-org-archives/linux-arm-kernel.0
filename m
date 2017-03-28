From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Mar 2017 12:45:33 +0200
Subject: [PATCH 4/4] ARM: dts: silk: Correct clock of DU1
In-Reply-To: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
References: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1490697933-5849-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second channel of the display unit uses a different module clock
than the first channel.

Fixes: 84e734f497cd48f6 ("ARM: dts: silk: add DU DT support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index c742d80d6dca8548..4cb5278d104dfcb3 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -424,7 +424,7 @@
 	status = "okay";
 
 	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-		 <&mstp7_clks R8A7794_CLK_DU0>,
+		 <&mstp7_clks R8A7794_CLK_DU1>,
 		 <&x2_clk>, <&x3_clk>;
 	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
 
-- 
2.7.4
