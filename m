From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:29 +0200
Subject: [PATCH v2 1/9] ARM64: dts: meson-gx: Use correct mmc clock source 0
In-Reply-To: <20170821160637.22456-1-jbrunet@baylibre.com>
References: <20170821160637.22456-1-jbrunet@baylibre.com>
Message-ID: <20170821160637.22456-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the clock source 0 is properly described in the CCF, use it
instead of assuming the default value (xtal)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
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
2.9.5
