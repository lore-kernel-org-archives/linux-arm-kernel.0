From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  6 Jan 2014 16:25:33 +0100
Subject: [PATCH] ARM: tegra: Remove 3.3V supply and modem regulators
Message-ID: <1389021933-6675-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO 1 and 2 of the PMIC are not used for the described purpose, so
remove them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note: Removing these makes the work-in-progress eDP support work again.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c6dcef513e5d..4b3f3658e7ff 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -980,28 +980,6 @@
 			regulator-always-on;
 		};
 
-		vdd_3v3_reg: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "vdd_3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-			regulator-boot-on;
-			enable-active-high;
-			gpio = <&as3722 1 GPIO_ACTIVE_HIGH>;
-		};
-
-		vdd_3v3_modem_reg: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "vdd-modem-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			enable-active-high;
-			gpio = <&as3722 2 GPIO_ACTIVE_HIGH>;
-		};
-
 		vdd_hdmi_5v0_reg: regulator at 3 {
 			compatible = "regulator-fixed";
 			reg = <3>;
-- 
1.8.4.2
