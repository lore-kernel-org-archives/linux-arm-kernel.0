From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Apr 2013 16:27:26 +0100
Subject: [RFC PATCH v2 04/13] ARM: mach-exynos: cpus/cpu nodes dts updates
In-Reply-To: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366644455-16550-5-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/exynos5440.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5f3562a..eda21d5 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -24,8 +24,12 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
 			compatible = "arm,cortex-a15";
+			reg = <0x0>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 13 0xf08>;
@@ -34,6 +38,7 @@
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a15";
+			reg = <0x1>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 14 0xf08>;
@@ -42,6 +47,7 @@
 		};
 		cpu at 2 {
 			compatible = "arm,cortex-a15";
+			reg = <0x2>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 14 0xf08>;
@@ -50,6 +56,7 @@
 		};
 		cpu at 3 {
 			compatible = "arm,cortex-a15";
+			reg = <0x3>;
 			timer {
 				compatible = "arm,armv7-timer";
 				interrupts = <1 14 0xf08>;
-- 
1.7.12
