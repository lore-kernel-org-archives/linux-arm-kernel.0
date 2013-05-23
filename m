From: jonas@microbit.se (Jonas Andersson)
Date: Thu, 23 May 2013 13:38:05 +0200
Subject: [PATCH] ARM: dts: imx: fix clocks for cspi
Message-ID: <1369309085-31146-1-git-send-email-jonas@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CSPI controller has only one clock, but the driver spi-imx.c needs clock "per" to calculate bitrate divisor.

Signed-off-by: Jonas Andersson <jonas@microbit.se>
---
 arch/arm/boot/dts/imx25.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx27.dtsi |  6 +++---
 arch/arm/boot/dts/imx51.dtsi |  2 +-
 arch/arm/boot/dts/imx53.dtsi |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index d2550e0..7011539 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -141,8 +141,8 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
 				reg = <0x43fa4000 0x4000>;
-				clocks = <&clks 62>;
-				clock-names = "ipg";
+				clocks = <&clks 62>, <&clks 62>;
+				clock-names = "ipg", "per";
 				interrupts = <14>;
 				status = "disabled";
 			};
@@ -182,8 +182,8 @@
 				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
 				reg = <0x50004000 0x4000>;
 				interrupts = <0>;
-				clocks = <&clks 80>;
-				clock-names = "ipg";
+				clocks = <&clks 80>, <&clks 80>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -210,8 +210,8 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
 				reg = <0x50010000 0x4000>;
-				clocks = <&clks 79>;
-				clock-names = "ipg";
+				clocks = <&clks 79>, <&clks 79>;
+				clock-names = "ipg", "per";
 				interrupts = <13>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index ff4bd48..75bd113 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -131,7 +131,7 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000e000 0x1000>;
 				interrupts = <16>;
-				clocks = <&clks 53>, <&clks 0>;
+				clocks = <&clks 53>, <&clks 53>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -142,7 +142,7 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000f000 0x1000>;
 				interrupts = <15>;
-				clocks = <&clks 52>, <&clks 0>;
+				clocks = <&clks 52>, <&clks 52>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -223,7 +223,7 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x10017000 0x1000>;
 				interrupts = <6>;
-				clocks = <&clks 51>, <&clks 0>;
+				clocks = <&clks 51>, <&clks 51>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 21bb786..53fdde6 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -631,7 +631,7 @@
 				compatible = "fsl,imx51-cspi", "fsl,imx35-cspi";
 				reg = <0x83fc0000 0x4000>;
 				interrupts = <38>;
-				clocks = <&clks 55>, <&clks 0>;
+				clocks = <&clks 55>, <&clks 55>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 845982e..eb83aa0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -714,7 +714,7 @@
 				compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
 				reg = <0x63fc0000 0x4000>;
 				interrupts = <38>;
-				clocks = <&clks 55>, <&clks 0>;
+				clocks = <&clks 55>, <&clks 55>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
-- 
1.8.1.4
