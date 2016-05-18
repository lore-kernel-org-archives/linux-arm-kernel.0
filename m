From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 18 May 2016 18:36:26 -0500
Subject: [PATCH 1/8] ARM: dts: am335x: Update MPU regulator range for TI boards
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
Message-ID: <8df50393ed0b2caf3f29408ad378ea16d94464db.1463606963.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we are moving to OPPv2 bindings and able to add 1GHz OPP for
MPU, let's update the max MPU voltage range to align with the maximum
possible value allowed in the operating-points table, which is max
target voltage of 132500 uV + 2%.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-evm.dts          | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 0cc150b87b86..13133f3587b8 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -318,7 +318,7 @@
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
-			regulator-max-microvolt = <1325000>;
+			regulator-max-microvolt = <1351500>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 516673bb023d..5d28712ad253 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -640,7 +640,7 @@
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912500>;
-			regulator-max-microvolt = <1312500>;
+			regulator-max-microvolt = <1351500>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 282fe1b37095..09308d66645b 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -560,7 +560,7 @@
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912500>;
-			regulator-max-microvolt = <1312500>;
+			regulator-max-microvolt = <1351500>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
-- 
2.7.3
