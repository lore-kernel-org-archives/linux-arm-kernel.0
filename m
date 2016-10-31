From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Oct 2016 17:44:43 +0100
Subject: [PATCH 5/8] ARM64: dts: meson-gxl: Add MMC/SD/SDIO nodes
In-Reply-To: <1477932286-27482-1-git-send-email-narmstrong@baylibre.com>
References: <1477932286-27482-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1477932286-27482-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MMC/SD/SDIO nodes clock attributes for Amlogic Meson GXL.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index b45df2a..d1bf381 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -235,3 +235,24 @@
 &i2c_C {
 	clocks = <&clkc CLKID_I2C>;
 };
+
+&sd_emmc_a {
+	clocks = <&clkc CLKID_SD_EMMC_A>,
+		 <&xtal>,
+		 <&clkc CLKID_FCLK_DIV2>;
+	clock-names = "core", "clkin0", "clkin1";
+};
+
+&sd_emmc_b {
+	clocks = <&clkc CLKID_SD_EMMC_B>,
+		 <&xtal>,
+		 <&clkc CLKID_FCLK_DIV2>;
+       clock-names = "core", "clkin0", "clkin1";
+};
+
+&sd_emmc_c {
+	clocks = <&clkc CLKID_SD_EMMC_C>,
+		 <&xtal>,
+		 <&clkc CLKID_FCLK_DIV2>;
+	clock-names = "core", "clkin0", "clkin1";
+};
-- 
1.9.1
