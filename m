From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  1 Sep 2013 22:01:52 +0200
Subject: [PATCH 3/4] ARM: nomadik: register VMMC regulator
Message-ID: <1378065712-18195-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the STw481x VMMC regulator to the Nomadik
device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 9169d30..0e543e0 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -707,8 +707,14 @@
 		pinctrl-0 = <&i2c0_default_mux>, <&i2c0_default_mode>;
 
 		stw4811 at 2d {
-			   compatible = "st,stw4811";
-			   reg = <0x2d>;
+			compatible = "st,stw4811";
+			reg = <0x2d>;
+			vmmc_regulator: vmmc {
+				compatible = "st,stw481x-vmmc";
+				regulator-name = "VMMC";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
 		};
 	};
 
@@ -839,6 +845,7 @@
 			cd-inverted;
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmcsd_default_mux>, <&mmcsd_default_mode>;
+			vmmc-supply = <&vmmc_regulator>;
 		};
 	};
 };
-- 
1.8.1.4
