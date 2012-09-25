From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 13:06:38 -0600
Subject: [RFC PATCH 3/3] ARM: tegra: compile all DT files with cpp
In-Reply-To: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1348599998-2729-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

We perform the minimum set of changes to convert the Tegra *.dts to
compile using the C pre-processor before dtc:

* Rename all the files to trigger the new build rule.
* Escape all property names that start with a # so they aren't seen as
  C pre-processor directives.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 ...tegra20-harmony.dts => tegra20-harmony.dts-cpp} |   10 +++---
 ...medcom-wide.dts => tegra20-medcom-wide.dts-cpp} |    4 +-
 .../{tegra20-paz00.dts => tegra20-paz00.dts-cpp}   |   14 ++++----
 .../{tegra20-plutux.dts => tegra20-plutux.dts-cpp} |    4 +-
 ...gra20-seaboard.dts => tegra20-seaboard.dts-cpp} |   22 ++++++------
 ...a20-tamonten.dtsi => tegra20-tamonten.dtsi-cpp} |    8 ++--
 .../dts/{tegra20-tec.dts => tegra20-tec.dts-cpp}   |    4 +-
 ...a20-trimslice.dts => tegra20-trimslice.dts-cpp} |    2 +-
 ...tegra20-ventana.dts => tegra20-ventana.dts-cpp} |   10 +++---
 ...gra20-whistler.dts => tegra20-whistler.dts-cpp} |    8 ++--
 .../boot/dts/{tegra20.dtsi => tegra20.dtsi-cpp}    |   30 +++++++++---------
 ...0-cardhu-a02.dts => tegra30-cardhu-a02.dts-cpp} |    6 ++--
 ...0-cardhu-a04.dts => tegra30-cardhu-a04.dts-cpp} |    6 ++--
 ...tegra30-cardhu.dtsi => tegra30-cardhu.dtsi-cpp} |   12 +++---
 .../boot/dts/{tegra30.dtsi => tegra30.dtsi-cpp}    |   34 ++++++++++----------
 15 files changed, 87 insertions(+), 87 deletions(-)
 rename arch/arm/boot/dts/{tegra20-harmony.dts => tegra20-harmony.dts-cpp} (98%)
 rename arch/arm/boot/dts/{tegra20-medcom-wide.dts => tegra20-medcom-wide.dts-cpp} (95%)
 rename arch/arm/boot/dts/{tegra20-paz00.dts => tegra20-paz00.dts-cpp} (98%)
 rename arch/arm/boot/dts/{tegra20-plutux.dts => tegra20-plutux.dts-cpp} (94%)
 rename arch/arm/boot/dts/{tegra20-seaboard.dts => tegra20-seaboard.dts-cpp} (98%)
 rename arch/arm/boot/dts/{tegra20-tamonten.dtsi => tegra20-tamonten.dtsi-cpp} (98%)
 rename arch/arm/boot/dts/{tegra20-tec.dts => tegra20-tec.dts-cpp} (94%)
 rename arch/arm/boot/dts/{tegra20-trimslice.dts => tegra20-trimslice.dts-cpp} (99%)
 rename arch/arm/boot/dts/{tegra20-ventana.dts => tegra20-ventana.dts-cpp} (98%)
 rename arch/arm/boot/dts/{tegra20-whistler.dts => tegra20-whistler.dts-cpp} (99%)
 rename arch/arm/boot/dts/{tegra20.dtsi => tegra20.dtsi-cpp} (93%)
 rename arch/arm/boot/dts/{tegra30-cardhu-a02.dts => tegra30-cardhu-a02.dts-cpp} (96%)
 rename arch/arm/boot/dts/{tegra30-cardhu-a04.dts => tegra30-cardhu-a04.dts-cpp} (96%)
 rename arch/arm/boot/dts/{tegra30-cardhu.dtsi => tegra30-cardhu.dtsi-cpp} (98%)
 rename arch/arm/boot/dts/{tegra30.dtsi => tegra30.dtsi-cpp} (93%)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts-cpp
similarity index 98%
rename from arch/arm/boot/dts/tegra20-harmony.dts
rename to arch/arm/boot/dts/tegra20-harmony.dts-cpp
index 74b8a47..b956919 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi-cpp"
 
 / {
 	model = "NVIDIA Tegra2 Harmony evaluation board";
@@ -254,7 +254,7 @@
 			interrupts = <187 0x04>;
 
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
@@ -283,7 +283,7 @@
 
 			ti,system-power-controller;
 
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 			gpio-controller;
 
 			sys-supply = <&vdd_5v0_reg>;
@@ -433,8 +433,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		vdd_5v0_reg: regulator at 0 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts-cpp
similarity index 95%
rename from arch/arm/boot/dts/tegra20-medcom-wide.dts
rename to arch/arm/boot/dts/tegra20-medcom-wide.dts-cpp
index a2d6d65..087c547 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsi-cpp"
 
 / {
 	model = "Avionic Design Medcom-Wide board";
@@ -14,7 +14,7 @@
 			interrupts = <187 0x04>;
 
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts-cpp
similarity index 98%
rename from arch/arm/boot/dts/tegra20-paz00.dts
rename to arch/arm/boot/dts/tegra20-paz00.dts-cpp
index 6a93d14..9df43c0 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi-cpp"
 
 / {
 	model = "Toshiba AC100 / Dynabook AZ";
@@ -248,7 +248,7 @@
 			compatible = "realtek,alc5632";
 			reg = <0x1e>;
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 		};
 	};
 
@@ -261,8 +261,8 @@
 		compatible = "nvidia,nvec";
 		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		clock-frequency = <80000>;
 		request-gpios = <&gpio 170 0>; /* gpio PV2 */
 		slave-addr = <138>;
@@ -277,7 +277,7 @@
 			reg = <0x34>;
 			interrupts = <0 86 0x4>;
 
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 			gpio-controller;
 
 			sys-supply = <&p5valw_reg>;
@@ -454,8 +454,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		p5valw_reg: regulator at 0 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts-cpp
similarity index 94%
rename from arch/arm/boot/dts/tegra20-plutux.dts
rename to arch/arm/boot/dts/tegra20-plutux.dts-cpp
index 331a3ef..67045ab 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsi-cpp"
 
 / {
 	model = "Avionic Design Plutux board";
@@ -14,7 +14,7 @@
 			interrupts = <187 0x04>;
 
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts-cpp
similarity index 98%
rename from arch/arm/boot/dts/tegra20-seaboard.dts
rename to arch/arm/boot/dts/tegra20-seaboard.dts-cpp
index 33ae813..2f7f039 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi-cpp"
 
 / {
 	model = "NVIDIA Seaboard";
@@ -305,7 +305,7 @@
 			interrupts = <187 0x04>;
 
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
@@ -335,8 +335,8 @@
 
 	i2cmux {
 		compatible = "i2c-mux-pinctrl";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		i2c-parent = <&{/i2c@7000c400}>;
 
@@ -347,14 +347,14 @@
 
 		i2c at 0 {
 			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			\#address-cells = <1>;
+			\#size-cells = <0>;
 		};
 
 		i2c at 1 {
 			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			\#address-cells = <1>;
+			\#size-cells = <0>;
 
 			smart-battery at b {
 				compatible = "ti,bq20z75", "smart-battery-1.1";
@@ -381,7 +381,7 @@
 
 			ti,system-power-controller;
 
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 			gpio-controller;
 
 			sys-supply = <&vdd_5v0_reg>;
@@ -596,8 +596,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		vdd_5v0_reg: regulator at 0 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi-cpp
similarity index 98%
rename from arch/arm/boot/dts/tegra20-tamonten.dtsi
rename to arch/arm/boot/dts/tegra20-tamonten.dtsi-cpp
index 5b3d8b1..2e964f0 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi-cpp
@@ -1,4 +1,4 @@
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi-cpp"
 
 / {
 	model = "Avionic Design Tamonten SOM";
@@ -257,7 +257,7 @@
 
 			ti,system-power-controller;
 
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 			gpio-controller;
 
 			sys-supply = <&vdd_5v0_reg>;
@@ -401,8 +401,8 @@
 	regulators {
 		compatible = "simple-bus";
 
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		vdd_5v0_reg: regulator at 0 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts-cpp
similarity index 94%
rename from arch/arm/boot/dts/tegra20-tec.dts
rename to arch/arm/boot/dts/tegra20-tec.dts-cpp
index 9aff31b..a84ac4d 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20-tamonten.dtsi"
+#include "tegra20-tamonten.dtsi-cpp"
 
 / {
 	model = "Avionic Design Tamonten Evaluation Carrier";
@@ -17,7 +17,7 @@
 			interrupts = <187 0x04>;
 
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts-cpp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-trimslice.dts
rename to arch/arm/boot/dts/tegra20-trimslice.dts-cpp
index 27fb8a6..de0bef8 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi-cpp"
 
 / {
 	model = "Compulab TrimSlice board";
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts-cpp
similarity index 98%
rename from arch/arm/boot/dts/tegra20-ventana.dts
rename to arch/arm/boot/dts/tegra20-ventana.dts-cpp
index 86854f1..6cff59d 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi-cpp"
 
 / {
 	model = "NVIDIA Tegra2 Ventana evaluation board";
@@ -260,7 +260,7 @@
 			interrupts = <187 0x04>;
 
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
@@ -297,7 +297,7 @@
 
 			ti,system-power-controller;
 
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 			gpio-controller;
 
 			sys-supply = <&vdd_5v0_reg>;
@@ -440,8 +440,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		vdd_5v0_reg: regulator at 0 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts-cpp
similarity index 99%
rename from arch/arm/boot/dts/tegra20-whistler.dts
rename to arch/arm/boot/dts/tegra20-whistler.dts-cpp
index 94a71c9..8657151 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra20.dtsi"
+#include "tegra20.dtsi-cpp"
 
 / {
 	model = "NVIDIA Tegra2 Whistler evaluation board";
@@ -259,7 +259,7 @@
 			compatible = "ti,tca6416";
 			reg = <0x20>;
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 		};
 
 		max8907 at 3c {
@@ -505,8 +505,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		usb0_vbus_reg: regulator {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi-cpp
similarity index 93%
rename from arch/arm/boot/dts/tegra20.dtsi
rename to arch/arm/boot/dts/tegra20.dtsi-cpp
index 6934bca..729d0f6 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi-cpp
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi-cpp"
 
 / {
 	compatible = "nvidia,tegra20";
@@ -15,7 +15,7 @@
 		reg = <0x50041000 0x1000
 		       0x50040100 0x0100>;
 		interrupt-controller;
-		#interrupt-cells = <3>;
+		\#interrupt-cells = <3>;
 	};
 
 	timer at 60005000 {
@@ -63,9 +63,9 @@
 			      0 55 0x04
 			      0 87 0x04
 			      0 89 0x04>;
-		#gpio-cells = <2>;
+		\#gpio-cells = <2>;
 		gpio-controller;
-		#interrupt-cells = <2>;
+		\#interrupt-cells = <2>;
 		interrupt-controller;
 	};
 
@@ -141,7 +141,7 @@
 	pwm: pwm {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-		#pwm-cells = <2>;
+		\#pwm-cells = <2>;
 	};
 
 	rtc {
@@ -154,8 +154,8 @@
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <0 38 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -163,8 +163,8 @@
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <0 84 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -172,8 +172,8 @@
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -181,8 +181,8 @@
 		compatible = "nvidia,tegra20-i2c-dvc";
 		reg = <0x7000d000 0x200>;
 		interrupts = <0 53 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -207,8 +207,8 @@
 	memory-controller at 7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 	};
 
 	usb at c5000000 {
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dts-cpp
similarity index 96%
rename from arch/arm/boot/dts/tegra30-cardhu-a02.dts
rename to arch/arm/boot/dts/tegra30-cardhu-a02.dts-cpp
index dd4222f..e5285c8 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30-cardhu.dtsi"
+#include "tegra30-cardhu.dtsi-cpp"
 
 /* This dts file support the cardhu A02 version of board */
 
@@ -10,8 +10,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		ddr_reg: regulator at 100 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts-cpp
similarity index 96%
rename from arch/arm/boot/dts/tegra30-cardhu-a04.dts
rename to arch/arm/boot/dts/tegra30-cardhu-a04.dts-cpp
index 0828f09..2f10bfb 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts-cpp
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "tegra30-cardhu.dtsi"
+#include "tegra30-cardhu.dtsi-cpp"
 
 /* This dts file support the cardhu A04 and later versions of board */
 
@@ -10,8 +10,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		ddr_reg: regulator at 100 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi-cpp
similarity index 98%
rename from arch/arm/boot/dts/tegra30-cardhu.dtsi
rename to arch/arm/boot/dts/tegra30-cardhu.dtsi-cpp
index b1271a8..45017b3 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi-cpp
@@ -1,4 +1,4 @@
-/include/ "tegra30.dtsi"
+#include "tegra30.dtsi-cpp"
 
 /**
  * This file contains common DT entry for all fab version of Cardhu.
@@ -128,7 +128,7 @@
 			interrupts = <179 0x04>; /* gpio PW3 */
 
 			gpio-controller;
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
@@ -153,12 +153,12 @@
 			reg = <0x2d>;
 
 			interrupts = <0 86 0x4>;
-			#interrupt-cells = <2>;
+			\#interrupt-cells = <2>;
 			interrupt-controller;
 
 			ti,system-power-controller;
 
-			#gpio-cells = <2>;
+			\#gpio-cells = <2>;
 			gpio-controller;
 
 			vcc1-supply = <&vdd_ac_bat_reg>;
@@ -276,8 +276,8 @@
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 
 		vdd_ac_bat_reg: regulator at 0 {
 			compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi-cpp
similarity index 93%
rename from arch/arm/boot/dts/tegra30.dtsi
rename to arch/arm/boot/dts/tegra30.dtsi-cpp
index 81f5df4..6f44e59 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi-cpp
@@ -1,4 +1,4 @@
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi-cpp"
 
 / {
 	compatible = "nvidia,tegra30";
@@ -15,7 +15,7 @@
 		reg = <0x50041000 0x1000
 		       0x50040100 0x0100>;
 		interrupt-controller;
-		#interrupt-cells = <3>;
+		\#interrupt-cells = <3>;
 	};
 
 	timer at 60005000 {
@@ -82,9 +82,9 @@
 			      0 87 0x04
 			      0 89 0x04
 			      0 125 0x04>;
-		#gpio-cells = <2>;
+		\#gpio-cells = <2>;
 		gpio-controller;
-		#interrupt-cells = <2>;
+		\#interrupt-cells = <2>;
 		interrupt-controller;
 	};
 
@@ -137,7 +137,7 @@
 	pwm: pwm {
 		compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-		#pwm-cells = <2>;
+		\#pwm-cells = <2>;
 	};
 
 	rtc {
@@ -150,8 +150,8 @@
 		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <0 38 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -159,8 +159,8 @@
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <0 84 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -168,8 +168,8 @@
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -177,8 +177,8 @@
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <0 120 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -186,8 +186,8 @@
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <0 53 0x04>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		\#address-cells = <1>;
+		\#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -223,8 +223,8 @@
 		nvidia,dma-request-selector = <&apbdma 1>;
 
 		ranges;
-		#address-cells = <1>;
-		#size-cells = <1>;
+		\#address-cells = <1>;
+		\#size-cells = <1>;
 
 		tegra_i2s0: i2s at 70080300 {
 			compatible = "nvidia,tegra30-i2s";
-- 
1.7.0.4
