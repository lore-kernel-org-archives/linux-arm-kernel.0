From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 19 May 2015 15:34:12 +0200
Subject: [RFC PATCH 2/4] ARM: dts: Add SPI flash node for Peach boards
In-Reply-To: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1432042454-19234-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Glass <sjg@chromium.org>

Peach Pit and Pi machines have a SPI flash memory that is used to
store firmware and different system parameters and data.

Add information about the SPI flash chip so that user-space tools
can access it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 146e71118a72..8e88088d6815 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -892,6 +892,13 @@
 		samsung,pin-drv = <2>;
 	};
 
+	spi_flash_cs: spi-flash-cs {
+		samsung,pins = "gpa2-5";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
 	usb300_vbus_en: usb300-vbus-en {
 		samsung,pins = "gph0-0";
 		samsung,pin-function = <1>;
@@ -921,6 +928,25 @@
 	clock-names = "rtc", "rtc_src";
 };
 
+&spi_1 {
+	status = "okay";
+	samsung,spi-src-clk = <0>;
+	num-cs = <1>;
+	cs-gpios = <&gpa2 5 0>;
+
+	spidev at 0 {
+		compatible = "google,spi-flash";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_flash_cs>;
+
+		controller-data {
+			samsung,spi-feedback-delay = <2>;
+		};
+	};
+};
+
 &spi_2 {
 	status = "okay";
 	num-cs = <1>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 02eb8b15374f..f2b89991b224 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -855,6 +855,13 @@
 		samsung,pin-drv = <2>;
 	};
 
+	spi_flash_cs: spi-flash-cs {
+		samsung,pins = "gpa2-5";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
 	usb300_vbus_en: usb300-vbus-en {
 		samsung,pins = "gph0-0";
 		samsung,pin-function = <1>;
@@ -884,6 +891,25 @@
 	clock-names = "rtc", "rtc_src";
 };
 
+&spi_1 {
+	status = "okay";
+	samsung,spi-src-clk = <0>;
+	num-cs = <1>;
+	cs-gpios = <&gpa2 5 0>;
+
+	spidev at 0 {
+		compatible = "google,spi-flash";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_flash_cs>;
+
+		controller-data {
+			samsung,spi-feedback-delay = <2>;
+		};
+	};
+};
+
 &spi_2 {
 	status = "okay";
 	num-cs = <1>;
-- 
2.1.4
