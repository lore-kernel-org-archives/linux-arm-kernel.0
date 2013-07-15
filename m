From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 10:51:43 -0600
Subject: [PATCH] ARM: tegra: fix DT node ordering in Tegra30 Cardhu
Message-ID: <1373907103-28418-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Nodes should be sorted by reg. Fix location of the tps62361 node.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I will immediately apply this to Tegra's for-3.12/dt branch.

 arch/arm/boot/dts/tegra30-cardhu.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index e5759ca..c011b67 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -173,19 +173,6 @@
 			gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
 		};
 
-		tps62361 {
-			compatible = "ti,tps62361";
-			reg = <0x60>;
-
-			regulator-name = "tps62361-vout";
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1500000>;
-			regulator-boot-on;
-			regulator-always-on;
-			ti,vsel0-state-high;
-			ti,vsel1-state-high;
-		};
-
 		pmic: tps65911 at 2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
@@ -293,6 +280,19 @@
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(CC, 2) IRQ_TYPE_LEVEL_LOW>;
 		};
+
+		tps62361 {
+			compatible = "ti,tps62361";
+			reg = <0x60>;
+
+			regulator-name = "tps62361-vout";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+			ti,vsel0-state-high;
+			ti,vsel1-state-high;
+		};
 	};
 
 	spi at 7000da00 {
-- 
1.8.1.5
