From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Mar 2017 12:45:31 +0200
Subject: [PATCH 2/4] ARM: dts: r8a7794: Correct clock of DU1
In-Reply-To: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
References: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1490697933-5849-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second channel of the display unit uses a different module clock
than the first channel.

Fixes: 46c4f13d04d729fa ("ARM: shmobile: r8a7794: Add DU node to device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index f5f8d1c03ef7c3a3..2f6e94fd408cc858 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -925,7 +925,7 @@
 		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-			 <&mstp7_clks R8A7794_CLK_DU0>;
+			 <&mstp7_clks R8A7794_CLK_DU1>;
 		clock-names = "du.0", "du.1";
 		status = "disabled";
 
-- 
2.7.4
