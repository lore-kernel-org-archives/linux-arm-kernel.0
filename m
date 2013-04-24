From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Apr 2013 18:28:14 +0100
Subject: [RFC PATCH v3 09/17] ARM: dts: omap: cpus/cpu nodes dts updates
In-Reply-To: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366824502-19729-10-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/omap2.dtsi | 6 +++++-
 arch/arm/boot/dts/omap3.dtsi | 5 +++++
 arch/arm/boot/dts/omap4.dtsi | 7 +++++++
 arch/arm/boot/dts/omap5.dtsi | 7 +++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 761c4b6..4183027 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -21,8 +21,12 @@
 	};
 
 	cpus {
-		cpu at 0 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
 			compatible = "arm,arm1136jf-s";
+			device_type = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..b6f6502 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -21,8 +21,13 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
+			device_type = "cpu";
+			reg = <0x0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..e0f943f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -28,13 +28,20 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			next-level-cache = <&L2>;
+			reg = <0x0>;
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			next-level-cache = <&L2>;
+			reg = <0x1>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 790bb2a..e3cc688 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -31,8 +31,13 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <0x0>;
 			timer {
 				compatible = "arm,armv7-timer";
 				/* 14th PPI IRQ, active low level-sensitive */
@@ -42,6 +47,8 @@
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <0x1>;
 			timer {
 				compatible = "arm,armv7-timer";
 				/* 14th PPI IRQ, active low level-sensitive */
-- 
1.7.12
