From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  8 Nov 2018 14:43:14 +0100
Subject: [PATCH] arm64: dts: zynqmp: Fix node names which contain "_"
Message-ID: <73038a438592d806874920f6680f2f3c7e20c0ad.1541684554.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s/_/-/ for node names.

It fixes warnings like this:
... Warning (node_name_chars_strict): /cpu_opp_table:
Character '_' not recommended in node name ...

Issues reported by make dtbs W=12

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

dr_mode property is also reported but it is not fixed because code needs
to fixed first.

---
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi        |  4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts |  4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 10 +++++-----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            |  4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
index 9c09baca7dd7..306ad2157c98 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
@@ -58,13 +58,13 @@
 		clock-accuracy = <100>;
 	};
 
-	dpdma_clk: dpdma_clk {
+	dpdma_clk: dpdma-clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0x0>;
 		clock-frequency = <533000000>;
 	};
 
-	drm_clock: drm_clock {
+	drm_clock: drm-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0x0>;
 		clock-frequency = <262750000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 527b4d0f88e2..13a0a028df98 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -82,7 +82,7 @@
 			linux,default-trigger = "bluetooth-power";
 		};
 
-		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
+		vbus-det { /* U5 USB5744 VBUS detection via MIO25 */
 			label = "vbus_det";
 			gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
@@ -98,7 +98,7 @@
 		regulator-boot-on;
 	};
 
-	sdio_pwrseq: sdio_pwrseq {
+	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 0397bf66b2e7..cef81671f3ab 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -53,7 +53,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
@@ -139,25 +139,25 @@
 		 * 7, 10 - 17 - not connected
 		 */
 
-		gtr_sel0 {
+		gtr-sel0 {
 			gpio-hog;
 			gpios = <0 0>;
 			output-low; /* PCIE = 0, DP = 1 */
 			line-name = "sel0";
 		};
-		gtr_sel1 {
+		gtr-sel1 {
 			gpio-hog;
 			gpios = <1 0>;
 			output-high; /* PCIE = 0, DP = 1 */
 			line-name = "sel1";
 		};
-		gtr_sel2 {
+		gtr-sel2 {
 			gpio-hog;
 			gpios = <2 0>;
 			output-high; /* PCIE = 0, USB0 = 1 */
 			line-name = "sel2";
 		};
-		gtr_sel3 {
+		gtr-sel3 {
 			gpio-hog;
 			gpios = <3 0>;
 			output-high; /* PCIE = 0, SATA = 1 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 7238f022a671..94cf5094df64 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -53,7 +53,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index fa055e718d4b..460adc378295 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -53,7 +53,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index ae3c1b929648..fa4fd777d90e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -71,7 +71,7 @@
 		};
 	};
 
-	cpu_opp_table: cpu_opp_table {
+	cpu_opp_table: cpu-opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp00 {
@@ -124,7 +124,7 @@
 			     <1 10 0xf08>;
 	};
 
-	amba_apu: amba_apu at 0 {
+	amba_apu: amba-apu at 0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
1.9.1
