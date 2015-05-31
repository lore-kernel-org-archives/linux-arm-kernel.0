From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 31 May 2015 11:15:06 +0200
Subject: [PATCH v3 2/4] ARM: dts: sun4i: Add A10 SRAM and SRAM controller
In-Reply-To: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1433063708-11726-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 has a few SRAM that can be mapped either to a device or to the CPU,
with the mapping being controlled by a SRAM controller.

Add the SRAM controller, the SRAM that it drives and the section that can
be used by the various devices.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts          |  4 +++
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts     |  4 +++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts     |  4 +++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts      |  4 +++
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts     |  4 +++
 arch/arm/boot/dts/sun4i-a10-marsboard.dts      |  4 +++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts |  4 +++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts        |  4 +++
 arch/arm/boot/dts/sun4i-a10.dtsi               | 37 ++++++++++++++++++++++++++
 9 files changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 8d220ba7f899..2630d78d9e04 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -108,6 +108,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index c7b0ba0cf416..93d435670ef1 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -74,6 +74,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 170811088fae..9afb4e018593 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -102,6 +102,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 6b944db678c8..2b17c5199151 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -86,6 +86,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &ir0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir0_rx_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index 483ddee1e384..dc2f2aeaff07 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -104,6 +104,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index 0bc950169943..02158bcd64ee 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -99,6 +99,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&emac_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 31b95fccfba1..b64aa4eb071e 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -105,6 +105,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 52c1777ff239..4e3e1b9d8217 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -119,6 +119,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index d7f43e5caf49..61c03d1fe530 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -454,6 +454,42 @@
 		#size-cells = <1>;
 		ranges;
 
+		sram-controller at 01c00000 {
+			compatible = "allwinner,sun4i-a10-sram-controller";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_a: sram at 00000000 {
+				compatible = "mmio-sram";
+				reg = <0x00000000 0xc000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00000000 0xc000>;
+
+				emac_sram: sram-section at 8000 {
+					compatible = "allwinner,sun4i-a10-sram-a3-a4";
+					reg = <0x8000 0x4000>;
+					status = "disabled";
+				};
+			};
+
+			sram_d: sram at 00010000 {
+				compatible = "mmio-sram";
+				reg = <0x00010000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00010000 0x1000>;
+
+				otg_sram: sram-section at 0000 {
+					compatible = "allwinner,sun4i-a10-sram-d";
+					reg = <0x0000 0x1000>;
+					status = "disabled";
+				};
+			};
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
@@ -495,6 +531,7 @@
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <55>;
 			clocks = <&ahb_gates 17>;
+			allwinner,sram = <&emac_sram 1>;
 			status = "disabled";
 		};
 
-- 
2.4.1
