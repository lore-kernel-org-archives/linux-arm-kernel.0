From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Mar 2013 16:13:20 +0800
Subject: [PATCH V4 9/9] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
References: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363594400-11663-10-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the PM configuration of PMC when the platform support suspend
function.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
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
index 3532853..06f4f68 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -416,6 +416,12 @@
 
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
index 41e82e3..3679382 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -415,6 +415,12 @@
 
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
index fd0e1cf..fd2a109 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -517,6 +517,12 @@
 
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
index 3cfd9ed..e210b24 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -300,6 +300,15 @@
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
index 826a6cc..0d6b8d7 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -493,6 +493,12 @@
 
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
index 847383f..073e65a 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -496,6 +496,14 @@
 
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
index 89eb495..698a634 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -253,6 +253,13 @@
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
index b448fca..4e26020 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -307,6 +307,13 @@
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
1.8.1.5
