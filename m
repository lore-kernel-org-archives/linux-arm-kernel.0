From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 3 Sep 2015 14:00:06 +0200
Subject: [PATCH 1/2] ARM: dts: am335x-phycore-som: Fix mpu voltage
Message-ID: <1441281607-35457-1-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the mpu voltage as it is set to low for the silicon
revision 2.1.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 4d28fc3..5dd084f 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -252,10 +252,10 @@
 		};
 
 		vdd1_reg: regulator at 2 {
-			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			/* VDD_MPU voltage limits 0.95V - 1.325V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912500>;
-			regulator-max-microvolt = <1312500>;
+			regulator-max-microvolt = <1378000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
-- 
1.9.1
