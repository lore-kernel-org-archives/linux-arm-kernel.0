From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  7 Jul 2013 10:12:30 -0300
Subject: [PATCH] ARM: dts: imx: Add the missing cpus node
Message-ID: <1373202750-10298-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

To make it consistent with the other i.mx SoCs, let's add the cpus nodes.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 10 ++++++++++
 arch/arm/boot/dts/imx27.dtsi | 10 ++++++++++
 arch/arm/boot/dts/imx31.dtsi | 10 ++++++++++
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index f590484..1bb9615 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -32,6 +32,16 @@
 		usb1 = &usbhost1;
 	};
 
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+		};
+	};
+
 	asic: asic-interrupt-controller at 68000000 {
 		compatible = "fsl,imx25-asic", "fsl,avic";
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index a587294..cca29ea 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -32,6 +32,16 @@
 		spi2 = &cspi3;
 	};
 
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+		};
+	};
+
 	aitc: aitc-interrupt-controller at e0000000 {
 		compatible = "fsl,imx27-aitc", "fsl,avic";
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 8116778..c34f825 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -20,6 +20,16 @@
 		serial4 = &uart5;
 	};
 
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm1136";
+			device_type = "cpu";
+		};
+	};
+
 	avic: avic-interrupt-controller at 60000000 {
 		compatible = "fsl,imx31-avic", "fsl,avic";
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index eb21034..34b7266 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -35,6 +35,16 @@
 		spi2 = &cspi;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a8";
+			reg = <0x0>;
+		};
+	};
+
 	tzic: tz-interrupt-controller at 0fffc000 {
 		compatible = "fsl,imx53-tzic", "fsl,tzic";
 		interrupt-controller;
-- 
1.8.1.2
