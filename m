From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:21 +0530
Subject: [PATCH 3/9] ARM: dts: rockchip: rk3288-vyasa: Use vmmc-supply from
 PMIC
In-Reply-To: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1508156187-27519-4-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk808, SWITCH_REG1 has configured for sdmmc regulator as vcc_sd,
so use the same by renaming vcc33_sd to vcc_sd(as per schematic)
and drop explicit regulator definition from root.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 915b4a3..c14ebf9 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -56,18 +56,6 @@
 		device_type = "memory";
 	};
 
-	vcc_sd: sdmmc-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwr>;
-		regulator-name = "vcc_sd";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <100000>;
-		vin-supply = <&vcc_io>;
-	};
-
 	vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -260,8 +248,8 @@
 				};
 			};
 
-			vcc33_sd: SWITCH_REG1 {
-				regulator-name = "vcc33_sd";
+			vcc_sd: SWITCH_REG1 {
+				regulator-name = "vcc_sd";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
@@ -338,10 +326,4 @@
 			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
-
-	sdmmc {
-		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
 };
-- 
2.7.4
