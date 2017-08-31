From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 31 Aug 2017 15:52:18 +0200
Subject: [PATCH v3 1/9] ARM64: dts: meson-gx: Use correct mmc clock source 0
In-Reply-To: <20170831135226.19784-1-jbrunet@baylibre.com>
References: <20170831135226.19784-1-jbrunet@baylibre.com>
Message-ID: <20170831135226.19784-2-jbrunet@baylibre.com>
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
index 52f1687e7a09..8f0c0cb02157 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -661,21 +661,21 @@
 
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
index d6876e64979e..829d84db5fc5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -603,21 +603,21 @@
 
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
