From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:51:04 +0900
Subject: [PATCH 34/34] ARM: shmobile: r8a7779 dtsi: Add SoC-specific SATA
 compatible property
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <25af9c83151822eb6d413b4d15d5f89804606ac7.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The SATA node used the generic compatible property only, which was
deprecated by commit e67adb4e669db834 ("sata_rcar: Add R-Car Gen2 SATA
PHY support"). Add the SoC-specific one introduced by that commit.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index fda814e..a884532 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -303,7 +303,7 @@
 	};
 
 	sata: sata at fc600000 {
-		compatible = "renesas,rcar-sata";
+		compatible = "renesas,sata-r8a7779", "renesas,rcar-sata";
 		reg = <0xfc600000 0x2000>;
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
-- 
2.1.1
