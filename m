From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  3 Oct 2017 17:24:42 +0200
Subject: [PATCH v2 1/2] ARM64: dts: meson-gxl: Take eMMC data strobe out of
 eMMC pins
In-Reply-To: <1507044283-18476-1-git-send-email-narmstrong@baylibre.com>
References: <1507044283-18476-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1507044283-18476-2-git-send-email-narmstrong@baylibre.com>
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
index 4157987..7d4b95e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -213,7 +213,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 4b17a76..a42c8f4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -302,7 +302,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "disabled";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 38dfdde..9a77323 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -272,7 +272,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1ffa1c2..0b97d9f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -271,7 +271,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 23c08c3..932158a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -242,7 +242,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index f2bc6de..1fe8e24 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -199,7 +199,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index af834cd..3d96a68 100644
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
index 977b424..e825825 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -141,7 +141,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 64c54c9..baaa03b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -221,7 +221,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 1b8f328..271f142 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -229,7 +229,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 129af90..ff09df1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -135,7 +135,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d8dd329..2e06397 100644
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
index 22c6977..e7a228f6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -193,7 +193,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 470f72b..a5e9b95 100644
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
2.7.4
