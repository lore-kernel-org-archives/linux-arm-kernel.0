From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:14 +0100
Subject: [PATCH 05/25] ARM: dts: r8a73a4: Use SoC-specific compat string for
 mmcif
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <5b0161743e194ab558143fdeea03243e35a5297f.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the SoC-specific compat string for mmcif in DT for the r8a73a4 SoC.
This is in keeping with the use of compat strings for mmcif for other
Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 53183ffe04c1..b138584b8800 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -440,7 +440,7 @@
 	};
 
 	mmcif0: mmc at ee200000 {
-		compatible = "renesas,sh-mmcif";
+		compatible = "renesas,mmcif-r8a73a4", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF0>;
@@ -450,7 +450,7 @@
 	};
 
 	mmcif1: mmc at ee220000 {
-		compatible = "renesas,sh-mmcif";
+		compatible = "renesas,mmcif-r8a73a4", "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF1>;
-- 
2.7.0.rc3.207.g0ac5344
