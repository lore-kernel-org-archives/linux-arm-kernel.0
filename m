From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:49 +0100
Subject: [RFC PATCH v4 06/18] ARM: dts: at91: cpus/cpu node dts updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-7-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 6 +++++-
 arch/arm/boot/dts/at91sam9260.dtsi | 8 ++++++--
 arch/arm/boot/dts/at91sam9263.dtsi | 8 ++++++--
 arch/arm/boot/dts/at91sam9g45.dtsi | 8 ++++++--
 arch/arm/boot/dts/at91sam9n12.dtsi | 8 ++++++--
 arch/arm/boot/dts/at91sam9x5.dtsi  | 8 ++++++--
 arch/arm/boot/dts/sama5d3.dtsi     | 2 ++
 7 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 5d3ed5a..0af879a 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -35,8 +35,12 @@
 		ssc2 = &ssc2;
 	};
 	cpus {
-		cpu at 0 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
 			compatible = "arm,arm920t";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 70b5ccb..e1ba7ea 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -32,8 +32,12 @@
 		ssc0 = &ssc0;
 	};
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 94b58ab..fcd38f8 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -29,8 +29,12 @@
 		ssc1 = &ssc1;
 	};
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index bf18a73..479a062 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -35,8 +35,12 @@
 		ssc1 = &ssc1;
 	};
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 3de8e6d..01df681 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -31,8 +31,12 @@
 		ssc0 = &ssc0;
 	};
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 1145ac3..6d8bd671 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -33,8 +33,12 @@
 		ssc0 = &ssc0;
 	};
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 2e643ea..5325371 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -36,7 +36,9 @@
 	};
 	cpus {
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a5";
+			reg = <0x0>;
 		};
 	};
 
-- 
1.8.2.2
