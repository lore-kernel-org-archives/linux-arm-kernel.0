From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  9 Sep 2016 10:01:08 -0400
Subject: [PATCH 7/8] ARM: dts: rockchip: Add missing unit name to memory nodes
 in rk3288 boards
In-Reply-To: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
References: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1473429669-6185-8-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warnings:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/rk3288-evb.dtsi                 | 2 +-
 arch/arm/boot/dts/rk3288-fennec.dts               | 2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi             | 2 +-
 arch/arm/boot/dts/rk3288-miqi.dts                 | 2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts             | 2 +-
 arch/arm/boot/dts/rk3288-r89.dts                  | 2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi           | 2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index d59208b5eb6c..bf7ccfad3260 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -43,7 +43,7 @@
 #include "rk3288.dtsi"
 
 / {
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-fennec.dts b/arch/arm/boot/dts/rk3288-fennec.dts
index 2e3c34135ed8..805c0d26770b 100644
--- a/arch/arm/boot/dts/rk3288-fennec.dts
+++ b/arch/arm/boot/dts/rk3288-fennec.dts
@@ -46,7 +46,7 @@
 	model = "Rockchip RK3288 Fennec Board";
 	compatible = "rockchip,rk3288-fennec", "rockchip,rk3288";
 
-	memory {
+	memory at 0 {
 		reg = <0x0 0x80000000>;
 		device_type = "memory";
 	};
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
index ec418c99de95..d242588bae0d 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
@@ -45,7 +45,7 @@
 #include "rk3288.dtsi"
 
 / {
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 114c90fb65e2..44935af1fb0e 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -44,7 +44,7 @@
 #include "rk3288.dtsi"
 
 / {
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index 24488421f0f0..441d450fd151 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -52,7 +52,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 56dd377d5658..23003a221234 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -48,7 +48,7 @@
 	model = "PopMetal-RK3288";
 	compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
 
-	memory{
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index 4b8a8adb243c..04faa72dbd95 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -48,7 +48,7 @@
 / {
 	compatible = "netxeon,r89", "rockchip,rk3288";
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index bb1f01e037ba..b25ba806d5ee 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -42,7 +42,7 @@
 #include "rk3288.dtsi"
 
 / {
-	memory {
+	memory at 0 {
 		reg = <0x0 0x80000000>;
 		device_type = "memory";
 	};
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 3dd2cca48c11..2251d28e9d2a 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -47,7 +47,7 @@
 #include "rk3288.dtsi"
 
 / {
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
-- 
2.7.4
