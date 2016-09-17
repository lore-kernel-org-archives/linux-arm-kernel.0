From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat, 17 Sep 2016 22:13:46 +0200
Subject: [PATCH devicetree] ARM: BCM53573: Specify PMU and its ILP clock in
 the DT
Message-ID: <20160917201346.15060-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

ILP clock (sometimes called a "slow clock") is a part of PMU (Power
Management Unit). There has been recently added a driver for it, so add
a proper entry in the DT as well.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm53573.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index efa07de..e2c496a 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -143,5 +143,17 @@
 		gmac1: ethernet at b000 {
 			reg = <0xb000 0x1000>;
 		};
+
+		pmu at 12000 {
+			compatible = "simple-mfd", "syscon";
+			reg = <0x00012000 0x00001000>;
+
+			ilp: ilp {
+				compatible = "brcm,bcm53573-ilp";
+				clocks = <&alp>;
+				#clock-cells = <0>;
+				clock-output-names = "ilp";
+			};
+		};
 	};
 };
-- 
2.9.3
