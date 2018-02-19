From: tmn505@gmail.com (Tomasz Maciej Nowak)
Date: Mon, 19 Feb 2018 21:16:23 +0100
Subject: [PATCH] ARM: dtc: tegra: enable front panel leds in TrimSlice
Message-ID: <20180219201623.6987-1-tmn505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds device nodes for two front panel LEDs.

Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 arch/arm/boot/dts/tegra20-trimslice.dts | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index d55c6b240a30..31a8b088d386 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -200,16 +200,17 @@
 			conf_ata {
 				nvidia,pins = "ata", "atc", "atd", "ate",
 					"crtp", "dap2", "dap3", "dap4", "dta",
-					"dtb", "dtc", "dtd", "dte", "gmb",
-					"gme", "i2cp", "pta", "slxc", "slxd",
-					"spdi", "spdo", "uda";
+					"dtb", "dtc", "dtd", "gmb", "gme",
+					"i2cp", "pta", "slxc", "slxd", "spdi",
+					"spdo", "uda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 			conf_atb {
 				nvidia,pins = "atb", "cdev1", "cdev2", "dap1",
-					"gma", "gmc", "gmd", "gpu", "gpu7",
-					"gpv", "sdio1", "slxa", "slxk", "uac";
+					"dte", "gma", "gmc", "gmd", "gpu",
+					"gpu7", "gpv", "sdio1", "slxa", "slxk",
+					"uac";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
@@ -402,6 +403,20 @@
 		};
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		ds2 {
+			label = "trimslice:green:right";
+			gpios = <&gpio TEGRA_GPIO(D, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		ds3 {
+			label = "trimslice:green:left";
+			gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
-- 
2.16.2
