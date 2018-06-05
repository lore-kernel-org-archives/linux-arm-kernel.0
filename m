From: khilman@baylibre.com (Kevin Hilman)
Date: Tue,  5 Jun 2018 14:59:37 -0700
Subject: [PATCH v2] ARM64: dts: meson: fix register ranges for SD/eMMC
Message-ID: <20180605215937.16634-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on updated information from Amlogic, correct the register range
for the SD/eMMC blocks to the right size.

Reported-by: Yixun Lan <yixun.lan@amlogic.com>
Tested-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index fee87737a201..67d7115e4eff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -132,7 +132,7 @@
 
 			sd_emmc_b: sd at 5000 {
 				compatible = "amlogic,meson-axg-mmc";
-				reg = <0x0 0x5000 0x0 0x2000>;
+				reg = <0x0 0x5000 0x0 0x800>;
 				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 				clocks = <&clkc CLKID_SD_EMMC_B>,
@@ -144,7 +144,7 @@
 
 			sd_emmc_c: mmc at 7000 {
 				compatible = "amlogic,meson-axg-mmc";
-				reg = <0x0 0x7000 0x0 0x2000>;
+				reg = <0x0 0x7000 0x0 0x800>;
 				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 				clocks = <&clkc CLKID_SD_EMMC_C>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 3c31e21cbed7..b003f324ca31 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -457,21 +457,21 @@
 
 			sd_emmc_a: mmc at 70000 {
 				compatible = "amlogic,meson-gx-mmc", "amlogic,meson-gxbb-mmc";
-				reg = <0x0 0x70000 0x0 0x2000>;
+				reg = <0x0 0x70000 0x0 0x800>;
 				interrupts = <GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			sd_emmc_b: mmc at 72000 {
 				compatible = "amlogic,meson-gx-mmc", "amlogic,meson-gxbb-mmc";
-				reg = <0x0 0x72000 0x0 0x2000>;
+				reg = <0x0 0x72000 0x0 0x800>;
 				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			sd_emmc_c: mmc at 74000 {
 				compatible = "amlogic,meson-gx-mmc", "amlogic,meson-gxbb-mmc";
-				reg = <0x0 0x74000 0x0 0x2000>;
+				reg = <0x0 0x74000 0x0 0x800>;
 				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
-- 
2.11.0
