From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:53 +0100
Subject: [RFC PATCH v4 10/18] ARM: dts: omap: cpus/cpu nodes dts updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-11-git-send-email-lorenzo.pieralisi@arm.com>
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
index 37aa748..4aac404 100644
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
index 82a404d..ba05d7f 100644
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
index 2a56428..33a9450 100644
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
index 3dd7ff8..35a6536 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -34,11 +34,18 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a15";
+			reg = <0x0>;
 		};
 		cpu at 1 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a15";
+			reg = <0x1>;
 		};
 	};
 
-- 
1.8.2.2
