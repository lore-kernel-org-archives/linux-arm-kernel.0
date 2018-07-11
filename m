From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 11:25:08 +0200
Subject: [PATCH 2/2] ARM: dts: sun5i: Fix the SRAM A3-A4 declaration
In-Reply-To: <20180711092508.18751-1-maxime.ripard@bootlin.com>
References: <20180711092508.18751-1-maxime.ripard@bootlin.com>
Message-ID: <20180711092508.18751-2-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the system control bindings, the A3-A4 SRAM node should be
a child node of the SRAM it belongs to. However, it was introduced at the
same level, therefore breaking the binding. Fix this.

Fixes: 85870196258f ("ARM: sun5i: a13: Merge common controllers into the common DTSI")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 4a089a64c2c7..e7a786a677d5 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -127,13 +127,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 0x00000000 0xc000>;
-			};
 
-			emac_sram: sram-section at 8000 {
-				compatible = "allwinner,sun5i-a13-sram-a3-a4",
-					     "allwinner,sun4i-a10-sram-a3-a4";
-				reg = <0x8000 0x4000>;
-				status = "disabled";
+				emac_sram: sram-section at 8000 {
+					compatible = "allwinner,sun5i-a13-sram-a3-a4",
+						     "allwinner,sun4i-a10-sram-a3-a4";
+					reg = <0x8000 0x4000>;
+					status = "disabled";
+				};
 			};
 
 			sram_c: sram at 1d00000 {
-- 
2.17.1
