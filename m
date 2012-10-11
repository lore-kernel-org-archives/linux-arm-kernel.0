From: mporter@ti.com (Matt Porter)
Date: Thu, 11 Oct 2012 15:04:38 -0400
Subject: [RFC PATCH v2 13/16] ARM: dts: add AM33XX MMC support
In-Reply-To: <1349982281-10785-1-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Message-ID: <1349982281-10785-14-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds AM33XX MMC support to the am33xx.dtsi and the BeagleBone
dts.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
 arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index c634f87..5510979 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -70,6 +70,8 @@
 		};
 
 		ldo3_reg: regulator at 5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
 
@@ -78,3 +80,7 @@
 		};
 	};
 };
+
+&mmc1 {
+	vmmc-supply = <&ldo3_reg>;
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 2ddb31b..ef8e105 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -233,6 +233,33 @@
 			status = "disabled";
 		};
 
+		mmc1: mmc at 48060000 {
+			compatible = "ti,omap3-hsmmc";
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+			ti,needs-special-reset;
+			dmas = <&edma 24
+				&edma 25>;
+			dma-names = "tx", "rx";
+		};
+
+		mmc2: mmc at 481d8000 {
+			compatible = "ti,omap3-hsmmc";
+			ti,hwmods = "mmc2";
+			ti,needs-special-reset;
+			dmas = <&edma 2
+				&edma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mmc3: mmc at 47810000 {
+			compatible = "ti,omap3-hsmmc";
+			ti,hwmods = "mmc3";
+			ti,needs-special-reset;
+			status = "disabled";
+		};
+
 		wdt2: wdt at 44e35000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
-- 
1.7.9.5
