From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:01:03 +0200
Subject: [PATCH v5 11/22] ARM: sun5i: Add support for the C1 SRAM region with
 the SRAM controller
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180710080114.31469-12-paul.kocialkowski@bootlin.com>
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
index 68711954c293..51dcefc76c12 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -137,6 +137,20 @@
 				status = "disabled";
 			};
 
+			sram_c: sram at 1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0x80000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0x80000>;
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
2.17.1
