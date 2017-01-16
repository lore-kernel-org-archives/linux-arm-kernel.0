From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 16 Jan 2017 17:57:53 +0100
Subject: [PATCH] arm64: dts: r8a7795: Add missing power-domains property for
 sata
Message-ID: <1484585873-30075-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This went unnoticed as the sata_rcar driver doesn't support Runtime PM
yet, but manages module clocks manually.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 972e379c05967c32..026a16ac41b422a1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1148,6 +1148,7 @@
 			reg = <0 0xee300000 0 0x1fff>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
-- 
1.9.1
