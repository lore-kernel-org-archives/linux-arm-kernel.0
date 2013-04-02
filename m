From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 2 Apr 2013 19:20:13 +0800
Subject: [PATCH V5 9/9] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364901613-25080-10-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the PM configuration of PMC when the platform support suspend
function.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V5:
* no change
V4:
* no change
V3:
* fix the configuration for paz00 board
V2:
* no change
---
 arch/arm/boot/dts/tegra20-harmony.dts   | 6 ++++++
 arch/arm/boot/dts/tegra20-paz00.dts     | 6 ++++++
 arch/arm/boot/dts/tegra20-seaboard.dts  | 6 ++++++
 arch/arm/boot/dts/tegra20-trimslice.dts | 9 +++++++++
 arch/arm/boot/dts/tegra20-ventana.dts   | 6 ++++++
 arch/arm/boot/dts/tegra20-whistler.dts  | 8 ++++++++
 arch/arm/boot/dts/tegra30-beaver.dts    | 7 +++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi   | 7 +++++++
 8 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 4f08521..7904eb4 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -429,6 +429,12 @@
 
 	pmc {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <5000>;
+		nvidia,cpu-pwr-off-time = <5000>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <3875>;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	usb at c5000000 {
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index c55e062..680eeeb 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -428,6 +428,12 @@
 
 	pmc {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <2000>;
+		nvidia,cpu-pwr-off-time = <0>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <0>;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	usb at c5000000 {
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 5572ee7..2ff92c9 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -530,6 +530,12 @@
 
 	pmc {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <5000>;
+		nvidia,cpu-pwr-off-time = <5000>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <3875>;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	memory-controller at 7000f400 {
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 8e8d4f6..7760b67 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -313,6 +313,15 @@
 		};
 	};
 
+	pmc {
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <5000>;
+		nvidia,cpu-pwr-off-time = <5000>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <3875>;
+		nvidia,sys-clock-req-active-high;
+	};
+
 	usb at c5000000 {
 		status = "okay";
 		nvidia,vbus-gpio = <&gpio 170 0>; /* gpio PV2 */
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 4363764..98a1eae 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -506,6 +506,12 @@
 
 	pmc {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <2000>;
+		nvidia,cpu-pwr-off-time = <100>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <458>;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	usb at c5000000 {
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 878790e..ff74be7 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -509,6 +509,14 @@
 
 	pmc {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <2000>;
+		nvidia,cpu-pwr-off-time = <1000>;
+		nvidia,core-pwr-good-time = <0 3845>;
+		nvidia,core-pwr-off-time = <93727>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
+		nvidia,combined-power-req;
 	};
 
 	usb at c5000000 {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 772e6cf..f17deb0 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -266,6 +266,13 @@
 	pmc {
 		status = "okay";
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <2000>;
+		nvidia,cpu-pwr-off-time = <200>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <0>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	sdhci at 78000000 {
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 053913f..9171834 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -320,6 +320,13 @@
 	pmc {
 		status = "okay";
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <2000>;
+		nvidia,cpu-pwr-off-time = <200>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <0>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	sdhci at 78000000 {
-- 
1.8.2
