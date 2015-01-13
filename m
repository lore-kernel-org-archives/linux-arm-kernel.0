From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 19:12:24 +0100
Subject: [PATCH v3 4/6] ARM: at91/dt: add SRAM nodes
In-Reply-To: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421172746-18727-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the SRAM available on atmel SoCs
For the at91sam9260 and the at91sam9g20, address mirroring is used to create a
single contiguous SRAM range instead of declaring two separate banks.

Also remove leftover TODOs in the sam9g45 file

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  |  5 +++++
 arch/arm/boot/dts/at91sam9260.dtsi |  5 +++++
 arch/arm/boot/dts/at91sam9261.dtsi |  5 +++++
 arch/arm/boot/dts/at91sam9263.dtsi | 10 ++++++++++
 arch/arm/boot/dts/at91sam9g20.dtsi |  9 +++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |  7 +++++--
 arch/arm/boot/dts/at91sam9n12.dtsi |  5 +++++
 arch/arm/boot/dts/at91sam9rl.dtsi  |  5 +++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |  5 +++++
 arch/arm/boot/dts/sama5d3.dtsi     |  5 +++++
 arch/arm/boot/dts/sama5d4.dtsi     |  5 +++++
 11 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index f449a864b81e..21c2b504f977 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -66,6 +66,11 @@
 		};
 	};
 
+	sram: sram at 00200000 {
+		compatible = "mmio-sram";
+		reg = <0x00200000 0x4000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index dd1313cbc314..fff0ee69aab4 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -69,6 +69,11 @@
 		};
 	};
 
+	sram0: sram at 002ff000 {
+		compatible = "mmio-sram";
+		reg = <0x002ff000 0x2000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index cdb9ed612109..e247b0b5fdab 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -60,6 +60,11 @@
 		};
 	};
 
+	sram: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x28000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index ef8a70c27439..8a210d5033b1 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -62,6 +62,16 @@
 		};
 	};
 
+	sram0: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x14000>;
+	};
+
+	sram1: sram at 00500000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x4000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index a50ee587a7af..f59301618163 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -16,6 +16,15 @@
 		reg = <0x20000000 0x08000000>;
 	};
 
+	sram0: sram at 002ff000 {
+		status = "disabled";
+	};
+
+	sram1: sram at 002fc000 {
+		compatible = "mmio-sram";
+		reg = <0x002fc000 0x8000>;
+	};
+
 	ahb {
 		apb {
 			i2c0: i2c at fffac000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2a8da8a884b4..ee80aa9c0759 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -74,6 +74,11 @@
 		};
 	};
 
+	sram: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x10000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -1287,7 +1292,6 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
-			//TODO
 			clocks = <&usb>, <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
 			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
@@ -1297,7 +1301,6 @@
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00800000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
-			//TODO
 			clocks = <&usb>, <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
 			clock-names = "usb_clk", "ehci_clk", "hclk", "uhpck";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 1d69db2e9e28..c2666a7cb5b1 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -64,6 +64,11 @@
 		};
 	};
 
+	sram: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x8000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 72424371413e..c055da2f151f 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -70,6 +70,11 @@
 		};
 	};
 
+	sram: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x4000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index bbb3ba65165f..818dabdd8c0e 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -72,6 +72,11 @@
 		};
 	};
 
+	sram: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x8000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index d701ddda0e00..e17614fe58a9 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -78,6 +78,11 @@
 		};
 	};
 
+	sram: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x20000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 0a2477fe5525..1b4fe4e19721 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -103,6 +103,11 @@
 		};
 	};
 
+	ns_sram: sram at 00210000 {
+		compatible = "mmio-sram";
+		reg = <0x00210000 0x10000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.1.0
