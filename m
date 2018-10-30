From: aford173@gmail.com (Adam Ford)
Date: Tue, 30 Oct 2018 09:37:18 -0500
Subject: [PATCH] Support RTC charging on PFUZE100
Message-ID: <20181030143718.10027-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
index 1e5dcac70045..74ab5d65106b 100755
--- a/arch/arm/boot/dts/imx6-logicpd-som.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
@@ -178,6 +178,12 @@
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
+
+			coin_reg: coin {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
 		};
 	};
 
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 659e516455be..bdef74077d1c 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -324,6 +324,7 @@ static struct pfuze_regulator pfuze100_regulators[] = {
 	PFUZE100_VGEN_REG(PFUZE100, VGEN4, PFUZE100_VGEN4VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN5, PFUZE100_VGEN5VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN6, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
+	PFUZE100_COIN_REG(PFUZE200, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
 };
 
 static struct pfuze_regulator pfuze200_regulators[] = {
@@ -377,6 +378,7 @@ static struct of_regulator_match pfuze100_matches[] = {
 	{ .name = "vgen4",	},
 	{ .name = "vgen5",	},
 	{ .name = "vgen6",	},
+	{ .name = "coin",	},
 };
 
 /* PFUZE200 */
-- 
2.17.1
