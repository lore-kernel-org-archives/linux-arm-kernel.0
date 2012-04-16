From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Apr 2012 10:53:04 -0600
Subject: [PATCH] ARM: dt: tegra: pinmux changes for USB ULPI
Message-ID: <1334595184-12252-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Ensure that the USB ULPI signals are not tri-stated, and have no pull-
up or pull-down.

Ensure that the pingroup hosting the USB ULPI reset signal (GPIO PV0 or
PV1 depending on the board, so UAC) is not tri-stated, and has no pull-
up or pull-down.

This change appears larger than it is due to the grouping and sorting of
the pin configuration data.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-harmony.dts   |   20 ++++++++++----------
 arch/arm/boot/dts/tegra-paz00.dts     |   14 +++++---------
 arch/arm/boot/dts/tegra-trimslice.dts |   18 +++++++++---------
 3 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 59bf1cf..6857cec 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -167,28 +167,28 @@
 			};
 			conf_ata {
 				nvidia,pins = "ata", "atb", "atc", "atd", "ate",
-					"cdev1", "dap1", "dtb", "gma", "gmb",
-					"gmc", "gmd", "gme", "gpu7", "gpv",
-					"i2cp", "pta", "rm", "slxa", "slxk",
-					"spia", "spib";
+					"cdev1", "cdev2", "dap1", "dtb", "gma",
+					"gmb", "gmc", "gmd", "gme", "gpu7",
+					"gpv", "i2cp", "pta", "rm", "slxa",
+					"slxk", "spia", "spib", "uac";
 				nvidia,pull = <0>;
 				nvidia,tristate = <0>;
 			};
-			conf_cdev2 {
-				nvidia,pins = "cdev2", "csus", "spid", "spif";
-				nvidia,pull = <1>;
-				nvidia,tristate = <1>;
-			};
 			conf_ck32 {
 				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
 					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
 				nvidia,pull = <0>;
 			};
+			conf_csus {
+				nvidia,pins = "csus", "spid", "spif";
+				nvidia,pull = <1>;
+				nvidia,tristate = <1>;
+			};
 			conf_crtp {
 				nvidia,pins = "crtp", "dap2", "dap3", "dap4",
 					"dtc", "dte", "dtf", "gpu", "sdio1",
 					"slxc", "slxd", "spdi", "spdo", "spig",
-					"uac", "uda";
+					"uda";
 				nvidia,pull = <0>;
 				nvidia,tristate = <1>;
 			};
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index fad92f2..34a9177 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -159,18 +159,14 @@
 			};
 			conf_ata {
 				nvidia,pins = "ata", "atb", "atc", "atd", "ate",
-					"cdev1", "dap1", "dap2", "dtf", "gma",
-					"gmb", "gmc", "gmd", "gme", "gpu",
-					"gpu7", "gpv", "i2cp", "pta", "rm",
-					"sdio1", "slxk", "spdo", "uac", "uda";
+					"cdev1", "cdev2", "dap1", "dap2", "dtf",
+					"gma", "gmb", "gmc", "gmd", "gme",
+					"gpu", "gpu7", "gpv", "i2cp", "pta",
+					"rm", "sdio1", "slxk", "spdo", "uac",
+					"uda";
 				nvidia,pull = <0>;
 				nvidia,tristate = <0>;
 			};
-			conf_cdev2 {
-				nvidia,pins = "cdev2";
-				nvidia,pull = <1>;
-				nvidia,tristate = <0>;
-			};
 			conf_ck32 {
 				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
 					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 71b73aa..e4fcf9a 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -182,23 +182,23 @@
 				nvidia,tristate = <1>;
 			};
 			conf_atb {
-				nvidia,pins = "atb", "cdev1", "dap1", "gma",
-					"gmc", "gmd", "gpu", "gpu7", "gpv",
-					"sdio1", "slxa", "slxk", "uac";
+				nvidia,pins = "atb", "cdev1", "cdev2", "dap1",
+					"gma", "gmc", "gmd", "gpu", "gpu7",
+					"gpv", "sdio1", "slxa", "slxk", "uac";
 				nvidia,pull = <0>;
 				nvidia,tristate = <0>;
 			};
-			conf_cdev2 {
-				nvidia,pins = "cdev2", "csus", "spia", "spib",
-					"spid", "spif";
-				nvidia,pull = <1>;
-				nvidia,tristate = <1>;
-			};
 			conf_ck32 {
 				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
 					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
 				nvidia,pull = <0>;
 			};
+			conf_csus {
+				nvidia,pins = "csus", "spia", "spib",
+					"spid", "spif";
+				nvidia,pull = <1>;
+				nvidia,tristate = <1>;
+			};
 			conf_ddc {
 				nvidia,pins = "ddc", "dtf", "rm", "sdc", "sdd";
 				nvidia,pull = <2>;
-- 
1.7.0.4
