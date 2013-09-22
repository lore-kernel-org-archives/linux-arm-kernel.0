From: cinifr@gmail.com (Fan Rong)
Date: Sun, 22 Sep 2013 20:21:27 +0800
Subject: [PATCH V3: Add Smp support for Allwinner A20. 2/3] Add cpuconfig
 nodes in dts for smp configure.
In-Reply-To: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
Message-ID: <1379852488-32147-3-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fan Rong <cinifr@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 999ff45..f745e0b 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -20,13 +20,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0  {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
 		};
 
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
@@ -167,6 +167,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		cpuconfig: cpuconfig at 01c25c00 {
+			compatible = "allwinner,sun7i-a20-cpuconfig";
+			reg = <0x01c25c00 0x400>;
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
1.8.1.2
