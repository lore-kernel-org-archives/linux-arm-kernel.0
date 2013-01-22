From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Jan 2013 17:41:27 -0800
Subject: [PATCH] ARM: dts: specify all the per-cpu interrupts of arch timer for
 exynos5440
Message-ID: <1358818887-16870-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Need to be changed requirements in the 'cpus' node for exynos5440
to specify all the per-cpu interrupts of arch timer.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5406689..c5bd8ed 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -28,7 +28,10 @@
 			compatible = "arm,cortex-a15";
 			timer {
 				compatible = "arm,armv7-timer";
-				interrupts = <1 13 0xf08>;
+				interrupts = <1 13 0xf08>,
+					     <1 14 0xf08>,
+					     <1 11 0xf08>,
+					     <1 10 0xf08>;
 				clock-frequency = <1000000>;
 			};
 		};
@@ -36,7 +39,10 @@
 			compatible = "arm,cortex-a15";
 			timer {
 				compatible = "arm,armv7-timer";
-				interrupts = <1 14 0xf08>;
+				interrupts = <1 13 0xf08>;
+					     <1 14 0xf08>,
+					     <1 11 0xf08>,
+					     <1 10 0xf08>;
 				clock-frequency = <1000000>;
 			};
 		};
@@ -44,7 +50,10 @@
 			compatible = "arm,cortex-a15";
 			timer {
 				compatible = "arm,armv7-timer";
-				interrupts = <1 14 0xf08>;
+				interrupts = <1 13 0xf08>;
+					     <1 14 0xf08>,
+					     <1 11 0xf08>,
+					     <1 10 0xf08>;
 				clock-frequency = <1000000>;
 			};
 		};
@@ -52,7 +61,10 @@
 			compatible = "arm,cortex-a15";
 			timer {
 				compatible = "arm,armv7-timer";
-				interrupts = <1 14 0xf08>;
+				interrupts = <1 13 0xf08>;
+					     <1 14 0xf08>,
+					     <1 11 0xf08>,
+					     <1 10 0xf08>;
 				clock-frequency = <1000000>;
 			};
 		};
-- 
1.7.10.4
