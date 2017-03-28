From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Mar 2017 12:45:32 +0200
Subject: [PATCH 3/4] ARM: dts: alt: Correct clock of DU1
In-Reply-To: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
References: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1490697933-5849-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second channel of the display unit uses a different module clock
than the first channel.

Fixes: 876e7fb9f418fd86 ("ARM: shmobile: r8a7794: alt: Enable VGA port")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 3fcf76b8e923be86..f1eea13cdf44371d 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -168,7 +168,7 @@
 	status = "okay";
 
 	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-		 <&mstp7_clks R8A7794_CLK_DU0>,
+		 <&mstp7_clks R8A7794_CLK_DU1>,
 		 <&x13_clk>, <&x2_clk>;
 	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
 
-- 
2.7.4
