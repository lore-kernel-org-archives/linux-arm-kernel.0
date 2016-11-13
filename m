From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:24:02 +0100
Subject: [PATCH v2 19/19] ARM: dts: armada-370-xp: Fixup regulator DT warning
In-Reply-To: <20161113212402.3060-1-gregory.clement@free-electrons.com>
References: <20161113212402.3060-1-gregory.clement@free-electrons.com>
Message-ID: <20161113212402.3060-20-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regulator has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 4 ++--
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 20ea2391da6e..9eb755534e70 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -186,7 +186,7 @@
 		pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin>;
 		pinctrl-names = "default";
 
-		sata1_regulator: sata1-regulator {
+		sata1_regulator: sata1-regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
 			regulator-name = "SATA1 Power";
@@ -199,7 +199,7 @@
 			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		sata2_regulator: sata2-regulator {
+		sata2_regulator: sata2-regulator at 2 {
 			compatible = "regulator-fixed";
 			reg = <2>;
 			regulator-name = "SATA2 Power";
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 45480d992e1e..ee3acb88ea8a 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -154,7 +154,7 @@
 			     &sata3_pwr_pin &sata4_pwr_pin>;
 		pinctrl-names = "default";
 
-		sata1_regulator: sata1-regulator {
+		sata1_regulator: sata1-regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
 			regulator-name = "SATA1 Power";
@@ -167,7 +167,7 @@
 			gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
 
-		sata2_regulator: sata2-regulator {
+		sata2_regulator: sata2-regulator at 2 {
 			compatible = "regulator-fixed";
 			reg = <2>;
 			regulator-name = "SATA2 Power";
@@ -180,7 +180,7 @@
 			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 		};
 
-		sata3_regulator: sata3-regulator {
+		sata3_regulator: sata3-regulator at 3 {
 			compatible = "regulator-fixed";
 			reg = <3>;
 			regulator-name = "SATA3 Power";
@@ -193,7 +193,7 @@
 			gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		};
 
-		sata4_regulator: sata4-regulator {
+		sata4_regulator: sata4-regulator at 4 {
 			compatible = "regulator-fixed";
 			reg = <4>;
 			regulator-name = "SATA4 Power";
-- 
2.10.2
