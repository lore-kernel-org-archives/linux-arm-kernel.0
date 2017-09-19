From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 19 Sep 2017 16:53:39 +0200
Subject: [PATCH 1/2] ARM64: dts: meson-gxl: Take eMMC data strobe out of eMMC
 pins
In-Reply-To: <1505832820-3517-1-git-send-email-narmstrong@baylibre.com>
References: <1505832820-3517-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1505832820-3517-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the Data Strobe pin is optional, take it out of the default
eMMC pins and add a separate entry.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                    | 10 ++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                     | 10 ++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             |  2 +-
 14 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index c89010e..4d32859 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -211,7 +211,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 9697a7a..4db30a4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -293,7 +293,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "disabled";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 9c59c3c..b876aaa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -270,7 +270,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index d147c85..96eb81a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -270,7 +270,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 81ffc689..147d229 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -237,7 +237,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 346753f..31a5765 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -197,7 +197,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 52f1687..ac3ad2a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -386,8 +386,14 @@
 			mux {
 				groups = "emmc_nand_d07",
 				       "emmc_cmd",
-				       "emmc_clk",
-				       "emmc_ds";
+				       "emmc_clk";
+				function = "emmc";
+			};
+		};
+
+		emmc_ds_pins: emmc-ds {
+			mux {
+				groups = "emmc_ds";
 				function = "emmc";
 			};
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index 2a5804c..3f0efd2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -140,7 +140,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 69ca14a..5ee4805 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -214,7 +214,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 4c2ac76..f4259a3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -227,7 +227,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index f3eea8e..0e971f7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -133,7 +133,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d6876e6..e75dafe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -275,8 +275,14 @@
 			mux {
 				groups = "emmc_nand_d07",
 				       "emmc_cmd",
-				       "emmc_clk",
-				       "emmc_ds";
+				       "emmc_clk";
+				function = "emmc";
+			};
+		};
+
+		emmc_ds_pins: emmc-ds {
+			mux {
+				groups = "emmc_ds";
 				function = "emmc";
 			};
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 9b10c5f..8bd127b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -192,7 +192,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 08f1dd6..c9e81de 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -216,7 +216,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-- 
1.9.1
