From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 25 Oct 2012 14:24:14 -0500
Subject: [PATCH V3 1/2] ARM: dts: OMAP: Add counter-32k nodes
In-Reply-To: <1351193055-12488-1-git-send-email-jon-hunter@ti.com>
References: <1351193055-12488-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1351193055-12488-2-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the counter-32k timers nodes present in OMAP2/3/4 devices and
device-tree binding documentation for OMAP counter-32k.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/arm/omap/counter.txt       |   15 +++++++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    6 ++++++
 arch/arm/boot/dts/omap2430.dtsi                    |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 ++++++
 arch/arm/boot/dts/omap4.dtsi                       |    6 ++++++
 5 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/counter.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/counter.txt b/Documentation/devicetree/bindings/arm/omap/counter.txt
new file mode 100644
index 0000000..5bd8aa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/counter.txt
@@ -0,0 +1,15 @@
+OMAP Counter-32K bindings
+
+Required properties:
+- compatible:	Must be "ti,omap-counter32k" for OMAP controllers
+- reg:		Contains timer register address range (base address and length)
+- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
+		"counter_32k"
+
+Example:
+
+counter32k: counter at 4a304000 {
+	compatible = "ti,omap-counter32k";
+	reg = <0x4a304000 0x20>;
+	ti,hwmods = "counter_32k";
+};
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index af5ee26..af65609 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -14,6 +14,12 @@
 	compatible = "ti,omap2420", "ti,omap2";
 
 	ocp {
+		counter32k: counter at 48004000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x48004000 0x20>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap2420_pmx: pinmux at 48000030 {
 			compatible = "ti,omap2420-padconf", "pinctrl-single";
 			reg = <0x48000030 0x0113>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 6887298..c392445 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -14,6 +14,12 @@
 	compatible = "ti,omap2430", "ti,omap2";
 
 	ocp {
+		counter32k: counter at 49020000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x49020000 0x20>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap2430_pmx: pinmux at 49002030 {
 			compatible = "ti,omap2430-padconf", "pinctrl-single";
 			reg = <0x49002030 0x0154>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index da8c0f5..805504a 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -61,6 +61,12 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
+		counter32k: counter at 48320000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x48320000 0x20>;
+			ti,hwmods = "counter_32k";
+		};
+
 		intc: interrupt-controller at 48200000 {
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3a82e0..23ee149 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -95,6 +95,12 @@
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
+		counter32k: counter at 4a304000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4a304000 0x20>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap4_pmx_core: pinmux at 4a100040 {
 			compatible = "ti,omap4-padconf", "pinctrl-single";
 			reg = <0x4a100040 0x0196>;
-- 
1.7.9.5
