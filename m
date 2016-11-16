From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 16 Nov 2016 13:15:38 -0200
Subject: [PATCH] ARM: dts: imx: Adjust CPU nodes
Message-ID: <1479309338-12803-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make CPU nodes consistent throughout the i.MX dts files, which
also matches the description from ePAPR spec.

This also fixes the following W=1 warning in some cases:

Warning (unit_address_vs_reg): Node /cpus/cpu at 0 has a unit name, but no reg property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx1.dtsi  | 3 ++-
 arch/arm/boot/dts/imx23.dtsi | 5 +++--
 arch/arm/boot/dts/imx25.dtsi | 5 +++--
 arch/arm/boot/dts/imx27.dtsi | 1 +
 arch/arm/boot/dts/imx28.dtsi | 5 +++--
 arch/arm/boot/dts/imx31.dtsi | 5 +++--
 arch/arm/boot/dts/imx35.dtsi | 5 +++--
 7 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index b792eee..dd3de38 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -43,8 +43,9 @@
 		#size-cells = <0>;
 		#address-cells = <1>;
 
-		cpu: cpu at 0 {
+		cpu at 0 {
 			device_type = "cpu";
+			reg = <0>;
 			compatible = "arm,arm920t";
 			operating-points = <200000 1900000>;
 			clock-latency = <62500>;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index ac2a9da..96eae64 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -29,12 +29,13 @@
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 831d09a..6a34815 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -43,12 +43,13 @@
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 9d8b596..6a7cb9e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -65,6 +65,7 @@
 
 		cpu: cpu at 0 {
 			device_type = "cpu";
+			reg = <0>;
 			compatible = "arm,arm926ej-s";
 			operating-points = <
 				/* kHz uV */
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 3aabf65..70927d5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -40,12 +40,13 @@
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 685916e..aa4d9cb 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -22,12 +22,13 @@
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm1136jf-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 9f40e62..6f7b943 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -27,12 +27,13 @@
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm1136jf-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
-- 
2.7.4
