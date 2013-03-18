From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Mar 2013 16:13:18 +0800
Subject: [PATCH V4 7/9] ARM: dts: tegra: add non-removable and
 keep-power-in-suspend property for MMC
In-Reply-To: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
References: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363594400-11663-8-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds "non-removable" property of MMC host where the eMMC device
is for Tegra platform.

And the "keep-power-in-suspend" property was used for the SDIO device that
need this to go into suspend mode (e.g. BRCM43xx series).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
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
index 9db36da..41e82e3 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -445,6 +445,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 715a8b8..fd0e1cf 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -580,6 +580,7 @@
 		status = "okay";
 		power-gpios = <&gpio 86 0>; /* gpio PK6 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
@@ -593,6 +594,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index ede91c0..826a6cc 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -516,6 +516,7 @@
 		status = "okay";
 		power-gpios = <&gpio 86 0>; /* gpio PK6 */
 		bus-width = <4>;
+		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
@@ -529,6 +530,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 4afcae1..847383f 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -518,6 +518,7 @@
 	sdhci at c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	kbc {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 0a2cd24..89eb495 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -266,6 +266,7 @@
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
index 3e2d210..b448fca 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -320,6 +320,7 @@
 	sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
+		non-removable;
 	};
 
 	regulators {
-- 
1.8.1.5
