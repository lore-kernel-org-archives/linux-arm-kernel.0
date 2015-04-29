From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 29 Apr 2015 22:32:27 +0000
Subject: [PATCH V2 6/6] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1430346747-28728-7-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the on-chip regulator support for all i.MX23 and
i.MX28 boards.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |   40 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx28.dtsi |   40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..efdd702 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -404,8 +404,46 @@
 			};
 
 			power at 80044000 {
+				compatible = "fsl,imx23-power", "syscon";
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <3>;
+
+				dcdc: regulator at 1 {
+					compatible = "fsl,imx23-dcdc";
+					regulator-name = "dcdc";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddd: regulator at 2 {
+					compatible = "fsl,imx23-vddd";
+					regulator-name = "vddd";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1550000>;
+					vddd-supply = <&reg_vdda>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vdda: regulator at 3 {
+					compatible = "fsl,imx23-vdda";
+					regulator-name = "vdda";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1950000>;
+					vdda-supply = <&reg_vddio>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddio: regulator at 4 {
+					compatible = "fsl,imx23-vddio";
+					regulator-name = "vddio";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3575000>;
+					regulator-microvolt-offset = <80000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
 			};
 
 			saif1: saif at 80046000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 25e25f8..378b1f2 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1035,8 +1035,46 @@
 			};
 
 			power: power at 80044000 {
+				compatible = "fsl,imx28-power", "syscon";
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <6>;
+
+				dcdc: regulator at 1 {
+					compatible = "fsl,imx28-dcdc";
+					regulator-name = "dcdc";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddd: regulator at 2 {
+					compatible = "fsl,imx28-vddd";
+					regulator-name = "vddd";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1550000>;
+					vddd-supply = <&reg_vdda>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vdda: regulator at 3 {
+					compatible = "fsl,imx28-vdda";
+					regulator-name = "vdda";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1950000>;
+					vdda-supply = <&reg_vddio>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddio: regulator at 4 {
+					compatible = "fsl,imx28-vddio";
+					regulator-name = "vddio";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3550000>;
+					regulator-microvolt-offset = <80000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
 			};
 
 			saif1: saif at 80046000 {
-- 
1.7.9.5
