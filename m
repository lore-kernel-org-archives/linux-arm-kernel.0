From: w.f@huawei.com (Fei Wang)
Date: Wed, 30 Sep 2015 19:05:08 +0800
Subject: [PATCH 5/8] arm64: dts: Add Hi655x regulator config node
In-Reply-To: <1443611111-3196-1-git-send-email-w.f@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
Message-ID: <1443611111-3196-6-git-send-email-w.f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add hi655x regulator dts file for Hi6220 SoC.

Signed-off-by: Fei Wang <w.f@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  245 +++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 4e4830b..40f895b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -176,5 +176,250 @@
                 interrupt-controller;
                 pmu_irq_gpio = <&gpio_pmu_irq_n>;
                 status = "ok";
+
+		ldo2: regulator at a21 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo2";
+                        regulator-min-microvolt = <2500000>;
+                        regulator-max-microvolt = <3200000>;
+                        hisilicon,valid-modes-mask = <0x02>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x029 0x02a 0x02b>;
+                        hisilicon,ctrl-data = <0x1 0x1>;
+                        hisilicon,vset-regs = <0x072>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <2500000>,<2600000>,
+						<2700000>,<2800000>,
+						<2900000>,<3000000>,
+						<3100000>,<3200000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "sensor_analog";
+                };
+
+		ldo7: regulator at a26 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo7";
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <3300000>;
+                        hisilicon,valid-modes-mask = <0x0a>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x029 0x02a 0x02b>;
+                        hisilicon,ctrl-data = <0x6 0x1>;
+                        hisilicon,vset-regs = <0x078>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <1800000>,<1850000>,
+						<2850000>,<2900000>,
+						<3000000>,<3100000>,
+						<3200000>,<3300000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "sd_card_io";
+		};
+
+		ldo10: regulator at a29 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo10";
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <3000000>;
+                        hisilicon,valid-modes-mask = <0x0a>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <360>;
+                        hisilicon,ctrl-regs = <0x02c 0x02d 0x02e>;
+                        hisilicon,ctrl-data = <0x1 0x1>;
+                        hisilicon,vset-regs = <0x07b>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <1800000>,<1850000>,
+						<1900000>,<2750000>,
+						<2800000>,<2850000>,
+						<2900000>,<3000000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "sd_card";
+                };
+
+		ldo13: regulator at a32 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo13";
+                        regulator-min-microvolt = <1600000>;
+                        regulator-max-microvolt = <1950000>;
+                        hisilicon,valid-modes-mask = <0x0a>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x02c 0x02d 0x02e>;
+                        hisilicon,ctrl-data = <0x4 0x1>;
+                        hisilicon,vset-regs = <0x07e>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <1600000>,<1650000>,
+						<1700000>,<1750000>,
+						<1800000>,<1850000>,
+						<1900000>,<1950000>;
+                        hisilicon,num_consumer_supplies = <3>;
+                        hisilicon,consumer-supplies = "scamera_core",
+							"mcamera_io",
+							"scamera_io";
+                };
+
+		ldo14: regulator at a33 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo14";
+                        regulator-min-microvolt = <2500000>;
+                        regulator-max-microvolt = <3200000>;
+                        hisilicon,valid-modes-mask = <0x02>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x02c 0x02d 0x02e>;
+                        hisilicon,ctrl-data = <0x5 0x1>;
+                        hisilicon,vset-regs = <0x07f>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <2500000>,<2600000>,
+						<2700000>,<2800000>,
+						<2900000>,<3000000>,
+						<3100000>,<3200000>;
+                        hisilicon,num_consumer_supplies = <3>;
+                        hisilicon,consumer-supplies  = "scamera_avdd",
+							"mcamera_avdd",
+							"mcamera_vcm";
+                };
+
+		ldo15: regulator at a34 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo15";
+                        regulator-min-microvolt = <1600000>;
+                        regulator-max-microvolt = <1950000>;
+                        regulator-boot-on;
+                        regulator-always-on;
+                        hisilicon,valid-modes-mask = <0x0a>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x02c 0x02d 0x02e>;
+                        hisilicon,ctrl-data = <0x6 0x1>;
+                        hisilicon,vset-regs = <0x080>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <1600000>,<1650000>,
+						<1700000>,<1750000>,
+						<1800000>,<1850000>,
+						<1900000>,<1950000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "codec_analog";
+                };
+
+		ldo17: regulator at a36 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo17";
+                        regulator-min-microvolt = <2500000>;
+                        regulator-max-microvolt = <3200000>;
+                        hisilicon,valid-modes-mask = <0x02>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x02f 0x030 0x031>;
+                        hisilicon,ctrl-data = <0x0 0x1>;
+                        hisilicon,vset-regs = <0x082>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <2500000>,<2600000>,
+						<2700000>,<2800000>,
+						<2900000>,<3000000>,
+						<3100000>,<3200000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "vibrator";
+                };
+
+		ldo19: regulator at a38 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo19";
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <3000000>;
+                        hisilicon,valid-modes-mask = <0x0a>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <360>;
+                        hisilicon,ctrl-regs = <0x02f 0x030 0x031>;
+                        hisilicon,ctrl-data = <0x2 0x1>;
+                        hisilicon,vset-regs = <0x084>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <1800000>,<1850000>,
+						<1900000>,<2750000>,
+						<2800000>,<2850000>,
+						<2900000>,<3000000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "emmc_vddm";
+                };
+
+		ldo21: regulator at a40 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo21";                                                                                                       regulator-min-microvolt = <1650000>;
+                        regulator-max-microvolt = <2000000>;
+                        regulator-always-on;
+                        hisilicon,valid-modes-mask = <0x02>;                                                                                            hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x02f 0x030 0x031>;
+                        hisilicon,ctrl-data = <0x4 0x1>;
+                        hisilicon,vset-regs = <0x086>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <1650000>,<1700000>,
+						<1750000>,<1800000>,
+						<1850000>,<1900000>,
+						<1950000>,<2000000>;
+                };
+
+		ldo22: regulator at a41 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo22";
+                        regulator-min-microvolt = <900000>;
+                        regulator-max-microvolt = <1200000>;
+                        regulator-boot-on;
+                        regulator-always-on;
+                        hisilicon,valid-modes-mask = <0x02>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x02f 0x030 0x031>;
+                        hisilicon,ctrl-data = <0x5 0x1>;
+                        hisilicon,vset-regs = <0x087>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table  = <900000>,<1000000>,
+						<1050000>,<1100000>,
+						<1150000>,<1175000>,
+						<1185000>,<1200000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "mcamera_core";
+                };
 	};
 };
-- 
1.7.9.5
