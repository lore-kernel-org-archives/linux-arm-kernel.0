From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 03 Sep 2012 14:34:34 +0200
Subject: [PATCH 3/3] ARM: dts: exynos4: Assume status of all optional nodes as
 disabled
In-Reply-To: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
References: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346675674-16034-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently all boards must explicitly disable all unused device tree
nodes of unused components (e.g. i2c, sdhci, etc...). This makes it
necessary to all boards to be aware of all components on the SoC, which
in turns makes board dts files longer and more difficult to maintain
(e.g. adding new components to SoC-level tree requires adding nodes with
status="disabled" to every board).

This patch changes "status" of all optional components in SoC-level dts
file to "disabled", adds status="okay" to respective nodes of used
components in dts of all boards and removes all nodes with only
status="disabled" from boards dts.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi            | 22 ++++++++++++
 arch/arm/boot/dts/exynos4210-origen.dts   | 58 ++-----------------------------
 arch/arm/boot/dts/exynos4210-smdkv310.dts | 52 +++------------------------
 3 files changed, 28 insertions(+), 104 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e446fe7..9b71b61 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -48,114 +48,133 @@
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 43 0>;
+		status = "disabled";
 	};
 
 	rtc at 10070000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
 		interrupts = <0 44 0>, <0 45 0>;
+		status = "disabled";
 	};
 
 	keypad at 100A0000 {
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
 		interrupts = <0 109 0>;
+		status = "disabled";
 	};
 
 	sdhci at 12510000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12510000 0x100>;
 		interrupts = <0 73 0>;
+		status = "disabled";
 	};
 
 	sdhci at 12520000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12520000 0x100>;
 		interrupts = <0 74 0>;
+		status = "disabled";
 	};
 
 	sdhci at 12530000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12530000 0x100>;
 		interrupts = <0 75 0>;
+		status = "disabled";
 	};
 
 	sdhci at 12540000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12540000 0x100>;
 		interrupts = <0 76 0>;
+		status = "disabled";
 	};
 
 	serial at 13800000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
 		interrupts = <0 52 0>;
+		status = "disabled";
 	};
 
 	serial at 13810000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13810000 0x100>;
 		interrupts = <0 53 0>;
+		status = "disabled";
 	};
 
 	serial at 13820000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13820000 0x100>;
 		interrupts = <0 54 0>;
+		status = "disabled";
 	};
 
 	serial at 13830000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13830000 0x100>;
 		interrupts = <0 55 0>;
+		status = "disabled";
 	};
 
 	i2c at 13860000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
 		interrupts = <0 58 0>;
+		status = "disabled";
 	};
 
 	i2c at 13870000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
 		interrupts = <0 59 0>;
+		status = "disabled";
 	};
 
 	i2c at 13880000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13880000 0x100>;
 		interrupts = <0 60 0>;
+		status = "disabled";
 	};
 
 	i2c at 13890000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13890000 0x100>;
 		interrupts = <0 61 0>;
+		status = "disabled";
 	};
 
 	i2c at 138A0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138A0000 0x100>;
 		interrupts = <0 62 0>;
+		status = "disabled";
 	};
 
 	i2c at 138B0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138B0000 0x100>;
 		interrupts = <0 63 0>;
+		status = "disabled";
 	};
 
 	i2c at 138C0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138C0000 0x100>;
 		interrupts = <0 64 0>;
+		status = "disabled";
 	};
 
 	i2c at 138D0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138D0000 0x100>;
 		interrupts = <0 65 0>;
+		status = "disabled";
 	};
 
 	spi_0: spi at 13920000 {
@@ -166,6 +185,7 @@
 		rx-dma-channel = <&pdma0 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	spi_1: spi at 13930000 {
@@ -176,6 +196,7 @@
 		rx-dma-channel = <&pdma1 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	spi_2: spi at 13940000 {
@@ -186,6 +207,7 @@
 		rx-dma-channel = <&pdma0 8>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	amba {
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 0c49caa..d1a1101 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -40,6 +40,7 @@
 			<&gpk2 4 2 3 3>,
 			<&gpk2 5 2 3 3>,
 			<&gpk2 6 2 3 3>;
+		status = "okay";
 	};
 
 	sdhci at 12510000 {
@@ -53,6 +54,7 @@
 			<&gpk0 4 2 3 3>,
 			<&gpk0 5 2 3 3>,
 			<&gpk0 6 2 3 3>;
+		status = "okay";
 	};
 
 	gpio_keys {
@@ -90,60 +92,4 @@
 			linux,code = <139>;
 		};
 	};
-
-	keypad at 100A0000 {
-		status = "disabled";
-	};
-
-	sdhci at 12520000 {
-		status = "disabled";
-	};
-
-	sdhci at 12540000 {
-		status = "disabled";
-	};
-
-	i2c at 13860000 {
-		status = "disabled";
-	};
-
-	i2c at 13870000 {
-		status = "disabled";
-	};
-
-	i2c at 13880000 {
-		status = "disabled";
-	};
-
-	i2c at 13890000 {
-		status = "disabled";
-	};
-
-	i2c at 138A0000 {
-		status = "disabled";
-	};
-
-	i2c at 138B0000 {
-		status = "disabled";
-	};
-
-	i2c at 138C0000 {
-		status = "disabled";
-	};
-
-	i2c at 138D0000 {
-		status = "disabled";
-	};
-
-	spi_0: spi at 13920000 {
-		status = "disabled";
-	};
-
-	spi_1: spi at 13930000 {
-		status = "disabled";
-	};
-
-	spi_2: spi at 13940000 {
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 1beccc8..b87cca2 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -40,6 +40,7 @@
 			<&gpk2 4 2 3 3>,
 			<&gpk2 5 2 3 3>,
 			<&gpk2 6 2 3 3>;
+		status = "okay";
 	};
 
 	keypad at 100A0000 {
@@ -47,6 +48,7 @@
 		samsung,keypad-num-columns = <8>;
 		linux,keypad-no-autorepeat;
 		linux,keypad-wakeup;
+		status = "okay";
 
 		row-gpios = <&gpx2 0 3 3 0>,
 			    <&gpx2 1 3 3 0>;
@@ -128,6 +130,7 @@
 		samsung,i2c-max-bus-freq = <20000>;
 		gpios = <&gpd1 0 2 3 0>,
 			<&gpd1 1 2 3 0>;
+		status = "okay";
 
 		eeprom at 50 {
 			compatible = "samsung,24ad0xd1";
@@ -140,58 +143,11 @@
 		};
 	};
 
-	sdhci at 12510000 {
-		status = "disabled";
-	};
-
-	sdhci at 12520000 {
-		status = "disabled";
-	};
-
-	sdhci at 12540000 {
-		status = "disabled";
-	};
-
-	i2c at 13870000 {
-		status = "disabled";
-	};
-
-	i2c at 13880000 {
-		status = "disabled";
-	};
-
-	i2c at 13890000 {
-		status = "disabled";
-	};
-
-	i2c at 138A0000 {
-		status = "disabled";
-	};
-
-	i2c at 138B0000 {
-		status = "disabled";
-	};
-
-	i2c at 138C0000 {
-		status = "disabled";
-	};
-
-	i2c at 138D0000 {
-		status = "disabled";
-	};
-
-	spi_0: spi at 13920000 {
-		status = "disabled";
-	};
-
-	spi_1: spi at 13930000 {
-		status = "disabled";
-	};
-
 	spi_2: spi at 13940000 {
 		gpios = <&gpc1 1 5 3 0>,
 			<&gpc1 3 5 3 0>,
 			<&gpc1 4 5 3 0>;
+		status = "okay";
 
 		w25x80 at 0 {
 			#address-cells = <1>;
-- 
1.7.12
