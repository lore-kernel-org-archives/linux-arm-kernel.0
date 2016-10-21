From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 21 Oct 2016 16:40:31 +0200
Subject: [RFC PATCH 06/13] ARM64: dts: meson-gxl: Add MMC/SD/SDIO nodes
In-Reply-To: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1477060838-14164-7-git-send-email-narmstrong@baylibre.com>
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
