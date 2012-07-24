From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 24 Jul 2012 11:48:55 +0530
Subject: [PATCH v2 4/4] arm/dts: Add tps65217 regulator DT data to
 am335x-bone.dts
In-Reply-To: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Message-ID: <1343110735-10640-5-git-send-email-anilkumar@ti.com>
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
 arch/arm/boot/dts/am335x-bone.dts |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a9af4db..8fdf43a 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,3 +18,31 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	tps: tps at 24 {
+		reg = <0x24>;
+	};
+};
+
+/include/ "tps65217.dtsi"
+
+&dcdc2_reg {
+	/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+	regulator-name = "vdd_mpu";
+	regulator-min-microvolt = <925000>;
+	regulator-max-microvolt = <1325000>;
+	regulator-boot-on;
+	regulator-always-on;
+};
+
+&dcdc3_reg {
+	/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+	regulator-name = "vdd_core";
+	regulator-min-microvolt = <925000>;
+	regulator-max-microvolt = <1150000>;
+	regulator-boot-on;
+	regulator-always-on;
+};
-- 
1.7.9.5
