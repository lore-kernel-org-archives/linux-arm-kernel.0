From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:43 +0100
Subject: [PATCH 48/61] ARM: dts: r8a7791: Update CMT compat strings
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <bf50e0ab4f5062bb9d4bb5dcb81a6673ea7e2473.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Use recently updated R-Car Gen2 CMT0 and CMT1 compat strings.

With this change in place we can keep device-specific configuration in
the driver and the driver can be able to support CMT1 specific features.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e888b5b0e135..a69d6f883b34 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -257,7 +257,7 @@
 	};
 
 	cmt0: timer at ffca0000 {
-		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
+		compatible = "renesas,r8a7791-cmt0", "renesas,rcar-gen2-cmt0";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -272,7 +272,7 @@
 	};
 
 	cmt1: timer at e6130000 {
-		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
+		compatible = "renesas,r8a7791-cmt1", "renesas,rcar-gen2-cmt1";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.11.0
