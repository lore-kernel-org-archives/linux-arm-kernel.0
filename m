From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:25 +0530
Subject: [PATCH 03/14] ARM: SPEAr: DT: Update pinctrl list
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <3010db1332777076eb4d026e4fe37f3684dd9167.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

This patch updates pinctrl configuration for SPEAr SoC's.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear1310-evb.dts | 23 +++++++++++++++++------
 arch/arm/boot/dts/spear1340-evb.dts | 35 +++++++++++++++++++++--------------
 arch/arm/boot/dts/spear320-evb.dts  |  6 +-----
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index dd4358b..08697ac 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -30,10 +30,14 @@
 			pinctrl-0 = <&state_default>;
 
 			state_default: pinmux {
-				i2c0-pmx {
+				i2c0 {
 					st,pins = "i2c0_grp";
 					st,function = "i2c0";
 				};
+				i2s0 {
+					st,pins = "i2s0_grp";
+					st,function = "i2s0";
+				};
 				i2s1 {
 					st,pins = "i2s1_grp";
 					st,function = "i2s1";
@@ -42,6 +46,10 @@
 					st,pins = "arm_gpio_grp";
 					st,function = "arm_gpio";
 				};
+				clcd {
+					st,pins = "clcd_grp" , "clcd_high_res";
+					st,function = "clcd";
+				};
 				eth {
 					st,pins = "gmii_grp";
 					st,function = "gmii";
@@ -74,11 +82,6 @@
 					st,pins = "i2c_1_2_grp";
 					st,function = "i2c_1_2";
 				};
-				pci {
-					st,pins = "pcie0_grp","pcie1_grp",
-						"pcie2_grp";
-					st,function = "pci";
-				};
 				smii {
 					st,pins = "smii_0_1_2_grp";
 					st,function = "smii_0_1_2";
@@ -88,6 +91,14 @@
 						"nand_16bit_grp";
 					st,function = "nand";
 				};
+				sata {
+					st,pins = "sata0_grp";
+					st,function = "sata";
+				};
+				pcie {
+					st,pins = "pcie1_grp", "pcie2_grp";
+					st,function = "pci_express";
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index c9a54e0..8e35c14 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -38,20 +38,15 @@
 					st,pins = "fsmc_8bit_grp";
 					st,function = "fsmc";
 				};
-				kbd {
-					st,pins = "keyboard_row_col_grp",
-						"keyboard_col5_grp";
-					st,function = "keyboard";
-				};
 				uart0 {
-					st,pins = "uart0_grp", "uart0_enh_grp";
+					st,pins = "uart0_grp";
 					st,function = "uart0";
 				};
-				i2c0-pmx {
+				i2c0 {
 					st,pins = "i2c0_grp";
 					st,function = "i2c0";
 				};
-				i2c1-pmx {
+				i2c1 {
 					st,pins = "i2c1_grp";
 					st,function = "i2c1";
 				};
@@ -64,14 +59,9 @@
 					st,function = "spdif_out";
 				};
 				ssp0 {
-					st,pins = "ssp0_grp", "ssp0_cs1_grp",
-						"ssp0_cs3_grp";
+					st,pins = "ssp0_grp", "ssp0_cs1_grp", "ssp0_cs2_grp", "ssp0_cs3_grp";
 					st,function = "ssp0";
 				};
-				pwm {
-					st,pins = "pwm2_grp", "pwm3_grp";
-					st,function = "pwm";
-				};
 				smi-pmx {
 					st,pins = "smi_grp";
 					st,function = "smi";
@@ -84,6 +74,18 @@
 					st,pins = "gmii_grp", "rgmii_grp";
 					st,function = "gmac";
 				};
+				cam0 {
+					st,pins = "cam0_grp";
+					st,function = "cam0";
+				};
+				cam1 {
+					st,pins = "cam1_grp";
+					st,function = "cam1";
+				};
+				cam2 {
+					st,pins = "cam2_grp";
+					st,function = "cam2";
+				};
 				cam3 {
 					st,pins = "cam3_grp";
 					st,function = "cam3";
@@ -108,6 +110,11 @@
 					st,pins = "sata_grp";
 					st,function = "sata";
 				};
+				pcie {
+					st,pins = "pcie_grp";
+					st,function = "pcie";
+				};
+
 			};
 		};
 
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index 082328b..3f87cd0 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -76,13 +76,9 @@
 					st,function = "mii2";
 				};
 				pwm0_1 {
-					st,pins = "pwm0_1_pin_14_15_grp";
+					st,pins = "pwm0_1_pin_37_38_grp";
 					st,function = "pwm0_1";
 				};
-				pwm2 {
-					st,pins = "pwm2_pin_13_grp";
-					st,function = "pwm2";
-				};
 			};
 		};
 
-- 
1.7.12.rc2.18.g61b472e
