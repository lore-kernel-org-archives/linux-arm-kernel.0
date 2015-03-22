From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 22 Mar 2015 00:30:01 +0000
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the on-chip regulator support for all i.MX23 and
i.MX28 boards.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx28.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..be0aee8 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -404,8 +404,73 @@
 			};
 
 			power at 80044000 {
+				compatible = "fsl,imx23-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <3>;
+				ranges;
+
+				dcdc: regulator at 80044010 {
+					reg = <0x80044010 0x10>,
+					      <0x80044090 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "misc-address",
+						    "status-address";
+					compatible = "fsl,imx23-dcdc";
+					regulator-name = "dcdc";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddd: regulator at 80044040 {
+					reg = <0x80044040 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx23-vddd";
+					regulator-name = "vddd";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1550000>;
+					vddd-supply = <&reg_vdda>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vdda: regulator at 80044050 {
+					reg = <0x80044050 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx23-vdda";
+					regulator-name = "vdda";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1950000>;
+					vdda-supply = <&reg_vddio>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddio: regulator at 80044060 {
+					reg = <0x80044060 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
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
index 02330f4..98c1be6 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1022,8 +1022,73 @@
 			};
 
 			power: power at 80044000 {
+				compatible = "fsl,imx28-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <6>;
+				ranges;
+
+				dcdc: regulator at 80044010 {
+					reg = <0x80044010 0x10>,
+					      <0x80044090 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "misc-address",
+						    "status-address";
+					compatible = "fsl,imx28-dcdc";
+					regulator-name = "dcdc";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddd: regulator at 80044040 {
+					reg = <0x80044040 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx28-vddd";
+					regulator-name = "vddd";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1550000>;
+					vddd-supply = <&reg_vdda>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vdda: regulator at 80044050 {
+					reg = <0x80044050 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx28-vdda";
+					regulator-name = "vdda";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1950000>;
+					vdda-supply = <&reg_vddio>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddio: regulator at 80044060 {
+					reg = <0x80044060 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
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
