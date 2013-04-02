From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 2 Apr 2013 19:20:11 +0800
Subject: [PATCH V5 7/9] ARM: dts: tegra: add non-removable and
 keep-power-in-suspend property for MMC
In-Reply-To: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364901613-25080-8-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds "non-removable" property of MMC host where the eMMC device
is for Tegra platform.

And the "keep-power-in-suspend" property was used for the SDIO device that
need this to go into suspend mode (e.g. BRCM43xx series).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V5:
* no change
V4:
* no change
V3:
* no change
V2:
* no change
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
index 54b05b2..c55e062 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -458,6 +458,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 3b347b8..5572ee7 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -593,6 +593,7 @@
 		status = "okay";
 		power-gpios = <&gpio 86 0>; /* gpio PK6 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
@@ -606,6 +607,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 112ef5c..4363764 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -529,6 +529,7 @@
 		status = "okay";
 		power-gpios = <&gpio 86 0>; /* gpio PK6 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
@@ -542,6 +543,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 0b04262..878790e 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -531,6 +531,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	kbc {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index c3e0f25..772e6cf 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -279,6 +279,7 @@
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
index eeea511..053913f 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -333,6 +333,7 @@
 	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	regulators {
-- 
1.8.2
