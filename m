From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 22 Mar 2015 00:30:03 +0000
Subject: [PATCH 7/7] ARM: dts: add OPPs for i.MX23/i.MX28
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1426984203-9133-8-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the OPPs for i.MX23/i.MX28 which are necessary
for cpufreq support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |   15 +++++++++++++--
 arch/arm/boot/dts/imx28.dtsi |   15 +++++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index be0aee8..885c79c 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -27,12 +27,23 @@
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0x0>;
+			operating-points = <
+				/* kHz	uV */
+				261819  1350000
+				360000  1350000
+				392728  1450000
+				454737  1550000
+			>;
+			clocks = <&clks 2>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			cpu-supply = <&reg_vddd>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 98c1be6..21c1921 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -38,12 +38,23 @@
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0x0>;
+			operating-points = <
+				/* kHz	uV */
+				261819  1350000
+				360000  1350000
+				392728  1450000
+				454737  1550000
+			>;
+			clocks = <&clks 4>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			cpu-supply = <&reg_vddd>;
 		};
 	};
 
-- 
1.7.9.5
