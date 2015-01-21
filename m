From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 21 Jan 2015 09:34:53 +0800
Subject: [PATCH v2 1/2] ARM: imx6sx-sdb: change default board as reva board
In-Reply-To: <1421804094-26379-1-git-send-email-peter.chen@freescale.com>
References: <1421804094-26379-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1421804094-26379-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6sx sdb board has two revisions, the current mainline one
is reva which is experimental and mainly for internal use. In
this commit, we rename imx6sx-sdb.dts to imx6sx-sdb.dtsi, and
move the reva dedicated contents to imx6sx-sdb-reva.dts.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 143 +++++++++++++++++++++
 .../boot/dts/{imx6sx-sdb.dts => imx6sx-sdb.dtsi}   | 130 -------------------
 3 files changed, 144 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-reva.dts
 rename arch/arm/boot/dts/{imx6sx-sdb.dts => imx6sx-sdb.dtsi} (83%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7be7a6f..50eff7b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -303,7 +303,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb
 dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-sabreauto.dtb \
-	imx6sx-sdb.dtb \
+	imx6sx-sdb-reva.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-qds.dtb \
 	ls1021a-twr.dtb
diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
new file mode 100644
index 0000000..c76b87c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6sx-sdb.dtsi"
+
+/ {
+	model = "Freescale i.MX6 SoloX SDB RevA Board";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze100 at 08 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&qspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi2>;
+	status = "okay";
+
+	flash0: s25fl128s at 0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+	};
+
+	flash1: s25fl128s at 1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dtsi
similarity index 83%
rename from arch/arm/boot/dts/imx6sx-sdb.dts
rename to arch/arm/boot/dts/imx6sx-sdb.dtsi
index cdffe84..33ea87e 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -169,114 +169,6 @@
 	status = "okay";
 };
 
-&i2c1 {
-        clock-frequency = <100000>;
-        pinctrl-names = "default";
-        pinctrl-0 = <&pinctrl_i2c1>;
-        status = "okay";
-
-	pmic: pfuze100 at 08 {
-		compatible = "fsl,pfuze100";
-		reg = <0x08>;
-
-		regulators {
-			sw1a_reg: sw1ab {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw1c_reg: sw1c {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3a {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3b_reg: sw3b {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw4_reg: sw4 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vgen1 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-				regulator-always-on;
-			};
-
-			vgen2_reg: vgen2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen3_reg: vgen3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen4_reg: vgen4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vgen5 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vgen6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
 &i2c4 {
         clock-frequency = <100000>;
         pinctrl-names = "default";
@@ -340,28 +232,6 @@
 	status = "okay";
 };
 
-&qspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi2>;
-	status = "okay";
-
-	flash0: s25fl128s at 0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spansion,s25fl128s";
-		spi-max-frequency = <66000000>;
-	};
-
-	flash1: s25fl128s at 1 {
-		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spansion,s25fl128s";
-		spi-max-frequency = <66000000>;
-	};
-};
-
 &ssi2 {
 	status = "okay";
 };
-- 
1.9.1
