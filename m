From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 31 Jul 2017 14:05:52 +0200
Subject: [PATCH] ARM64: dts: meson-gx: Use correct mmc clock source 0
Message-ID: <20170731120552.31606-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the clock source 0 is properly described in the CCF, use it
instead of assuming the default value (xtal)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

This patchset depends on clock patchset adding the related clocks:
* https://lkml.kernel.org/r/20170731115603.29720-1-jbrunet at baylibre.com

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 +++---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 17d3efdf1469..9a1e478f80d5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -652,21 +652,21 @@
 
 &sd_emmc_a {
 	clocks = <&clkc CLKID_SD_EMMC_A>,
-		 <&xtal>,
+		 <&clkc CLKID_SD_EMMC_A_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
 
 &sd_emmc_b {
 	clocks = <&clkc CLKID_SD_EMMC_B>,
-		 <&xtal>,
+		 <&clkc CLKID_SD_EMMC_B_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
 
 &sd_emmc_c {
 	clocks = <&clkc CLKID_SD_EMMC_C>,
-		 <&xtal>,
+		 <&clkc CLKID_SD_EMMC_C_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8d4f3160a0ee..071eca074a91 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -593,21 +593,21 @@
 
 &sd_emmc_a {
 	clocks = <&clkc CLKID_SD_EMMC_A>,
-		 <&xtal>,
+		 <&clkc CLKID_SD_EMMC_A_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
 
 &sd_emmc_b {
 	clocks = <&clkc CLKID_SD_EMMC_B>,
-		 <&xtal>,
+		 <&clkc CLKID_SD_EMMC_B_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
        clock-names = "core", "clkin0", "clkin1";
 };
 
 &sd_emmc_c {
 	clocks = <&clkc CLKID_SD_EMMC_C>,
-		 <&xtal>,
+		 <&clkc CLKID_SD_EMMC_C_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
-- 
2.9.4
