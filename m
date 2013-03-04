From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 4 Mar 2013 19:41:32 +0800
Subject: [PATCH 09/10] ARM: dts: tegra: add non-removable and
 keep-power-in-suspend property for MMC
Message-ID: <1362397292-6122-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds "non-removable" property of MMC host where the eMMC device
is for Tegra platform.

And the "keep-power-in-suspend" property was used for the SDIO device that
need this to go into suspend mode (e.g. BRCM43xx series).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts      | 1 +
 arch/arm/boot/dts/tegra20-seaboard.dts   | 2 ++
 arch/arm/boot/dts/tegra20-ventana.dts    | 2 ++
 arch/arm/boot/dts/tegra20-whistler.dts   | 1 +
 arch/arm/boot/dts/tegra30-beaver.dts     | 1 +
 arch/arm/boot/dts/tegra30-cardhu-a02.dts | 1 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts | 1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi    | 1 +
 8 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 3929805..cd8e798 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -452,6 +452,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 6c2f88f..fd2a109 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -586,6 +586,7 @@
 		status = "okay";
 		power-gpios = <&gpio 86 0>; /* gpio PK6 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
@@ -599,6 +600,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index c428cd0..0d6b8d7 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -522,6 +522,7 @@
 		status = "okay";
 		power-gpios = <&gpio 86 0>; /* gpio PK6 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
@@ -535,6 +536,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index dd8c04b..073e65a 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -526,6 +526,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	kbc {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index ac6f048..698a634 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -273,6 +273,7 @@
 	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	regulators {
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
index adc88aa..e392bd2 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
@@ -88,6 +88,7 @@
 		status = "okay";
 		power-gpios = <&gpio 28 0>; /* gpio PD4 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index 08163e1..d0db6c7 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -100,5 +100,6 @@
 		status = "okay";
 		power-gpios = <&gpio 27 0>; /* gpio PD3 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 39b8438..4e26020 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -327,6 +327,7 @@
 	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	regulators {
-- 
1.8.1.1
