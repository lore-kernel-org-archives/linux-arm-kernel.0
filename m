From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 21 Aug 2012 16:47:30 +0530
Subject: [PATCH v3 4/4] arm/dts: Add tps65217 regulator DT data to
 am335x-bone.dts
In-Reply-To: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
Message-ID: <1345547850-29761-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tps65217 regulator device tree data to AM335x-Bone by adding
regulator consumers with tightened constraints and regulator-name.
TPS65217 regulator handle can be obtained by using this regulator
name.

This patch also add I2C node with I2C frequency and tps65217 PMIC
I2C slave address.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 58f5042..f1c2772 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -36,5 +36,59 @@
 		uart1: serial at 44E09000 {
 			status = "okay";
 		};
+
+		i2c1: i2c at 44E0B000 {
+			status = "okay";
+			clock-frequency = <400000>;
+
+			tps: tps at 24 {
+				reg = <0x24>;
+			};
+
+		};
+	};
+};
+
+/include/ "tps65217.dtsi"
+
+&tps {
+	regulators {
+		dcdc1_reg: regulator at 0 {
+			regulator-always-on;
+		};
+
+		dcdc2_reg: regulator at 1 {
+			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <1325000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc3_reg: regulator at 2 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+			regulator-name = "vdd_core";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <1150000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo1_reg: regulator at 3 {
+			regulator-always-on;
+		};
+
+		ldo2_reg: regulator at 4 {
+			regulator-always-on;
+		};
+
+		ldo3_reg: regulator at 5 {
+			regulator-always-on;
+		};
+
+		ldo4_reg: regulator at 6 {
+			regulator-always-on;
+		};
 	};
 };
-- 
1.7.9.5
