From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 23 May 2012 11:42:54 +0530
Subject: [PATCH V2 2/2] ARM: dt: tegra: cardhu: register core regulator
 tps65911
In-Reply-To: <1337753574-32699-1-git-send-email-ldewangan@nvidia.com>
References: <1337753574-32699-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1337753574-32699-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device info for the PMIC device tps65911 in tegra-cardhu
dts file. This device supports the multiple regulator rails,
gpio, interrupts.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
Change the label name ax <name>_reg to reg_<name> as per suggestions.

 arch/arm/boot/dts/tegra-cardhu.dts |   94 ++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index 36321bc..426281c 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -126,6 +126,100 @@
 			ti,vsel0-state-high;
 			ti,vsel1-state-high;
 		};
+
+		tps65911: tps65911 at 2d {
+			compatible = "ti,tps65911";
+			reg = <0x2d>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				reg_vdd1: vdd1 {
+					regulator-name = "vdd1";
+					regulator-min-microvolt = < 600000>;
+					regulator-max-microvolt = <1500000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				reg_vdd2: vdd2 {
+					regulator-name = "vdd2";
+					regulator-min-microvolt = < 600000>;
+					regulator-max-microvolt = <1500000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddctrl: vddctrl {
+					regulator-name = "vddctrl";
+					regulator-min-microvolt = < 600000>;
+					regulator-max-microvolt = <1400000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				reg_vio: vio {
+					regulator-name = "vio";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				reg_ldo1: ldo1 {
+					regulator-name = "ldo1";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				reg_ldo2: ldo2 {
+					regulator-name = "ldo2";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+				};
+
+				reg_ldo3: ldo3 {
+					regulator-name = "ldo3";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				reg_ldo4: ldo4 {
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				reg_ldo5: ldo5 {
+					regulator-name = "ldo5";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				reg_ldo6: ldo6 {
+					regulator-name = "ldo6";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				reg_ldo7: ldo7 {
+					regulator-name = "ldo7";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				reg_ldo8: ldo8 {
+					regulator-name = "ldo8";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+			};
+		};
 	};
 
 	ahub {
-- 
1.7.1.1
