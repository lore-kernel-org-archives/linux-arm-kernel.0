From: khilman@baylibre.com (Kevin Hilman)
Date: Mon,  4 Jun 2018 15:27:06 -0700
Subject: [PATCH] ARM64: dts: meson-axg: fix register ranges for SD/eMMC
Message-ID: <20180604222706.36167-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on updated information from Amlogic, correct the register
range for the SD/eMMC blocks to the right size.

Reported-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Yixun, please test and confirm this still works on AXG boards.

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.11.0
