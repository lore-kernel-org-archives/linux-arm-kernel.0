From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Mar 2018 12:55:43 +0100
Subject: [PATCH 2/4] ARM64: dts: meson-gx: sysctrl is the parent of the clock
 controller
In-Reply-To: <20180315115545.1884-1-jbrunet@baylibre.com>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
Message-ID: <20180315115545.1884-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent of the meson-gx clock controller should be the hhi system
controller, not the HIU bus. This way, the HHI register region can be
used safely by multiple drivers

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index cac72acb85b1..a48d2b821a49 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -304,11 +304,10 @@
 	clock-names = "isfr", "iahb", "venci";
 };
 
-&hiubus {
-	clkc: clock-controller at 0 {
+&sysctrl {
+	clkc: clock-controller {
 		compatible = "amlogic,gxbb-clkc";
 		#clock-cells = <1>;
-		reg = <0x0 0x0 0x0 0x3db>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index e1a39cbed8c9..6b7dfa2d48e4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -206,11 +206,10 @@
 	clock-names = "isfr", "iahb", "venci";
 };
 
-&hiubus {
-	clkc: clock-controller at 0 {
+&sysctrl {
+	clkc: clock-controller {
 		compatible = "amlogic,gxl-clkc", "amlogic,gxbb-clkc";
 		#clock-cells = <1>;
-		reg = <0x0 0x0 0x0 0x3db>;
 	};
 };
 
-- 
2.14.3
