From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon,  7 May 2018 14:44:51 +0200
Subject: [PATCH v3 05/14] ARM: sun5i: Add support for the C1 SRAM region with
 the SRAM controller
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180507124500.20434-6-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

This adds support for the C1 SRAM region (to be used with the SRAM
controller driver) for sun5i-based platforms. The region is shared
between the Video Engine and the CPU.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 72433f38b4e4..6fa9e28edc59 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -135,6 +135,20 @@
 				status = "disabled";
 			};
 
+			sram_c: sram at 1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0xd00000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0xd00000>;
+
+				ve_sram: sram-section at 0 {
+					compatible = "allwinner,sun5i-a13-sram-c1",
+						     "allwinner,sun4i-a10-sram-c1";
+					reg = <0x000000 0x80000>;
+				};
+			};
+
 			sram_d: sram at 10000 {
 				compatible = "mmio-sram";
 				reg = <0x00010000 0x1000>;
-- 
2.16.3
