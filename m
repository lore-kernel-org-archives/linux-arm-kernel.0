From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:39 +0100
Subject: [PATCH 09/69] arm64: dts: renesas: r8a7795: update register size for
 thermal
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <cd8325dc194d6fa0707c9d5b427ca1fed6893b53.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

To be able to read fused calibration values from hardware the size of
the register resource of TSC1 needs to be incremented to cover one more
register which holds the information if the calibration values have been
fused or not.

Instead of increasing TSC1 size to the value from the datasheet update
all TSC's size to the smallest granularity of the address decoder
circuitry

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 19b7de57704c..ce85704976f0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2385,9 +2385,9 @@
 
 		tsc: thermal at e6198000 {
 			compatible = "renesas,r8a7795-thermal";
-			reg = <0 0xe6198000 0 0x68>,
-			      <0 0xe61a0000 0 0x5c>,
-			      <0 0xe61a8000 0 0x5c>;
+			reg = <0 0xe6198000 0 0x100>,
+			      <0 0xe61a0000 0 0x100>,
+			      <0 0xe61a8000 0 0x100>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
