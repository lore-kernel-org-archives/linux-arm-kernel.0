From: broonie@kernel.org (Mark Brown)
Date: Mon,  1 Jul 2013 22:36:39 +0100
Subject: [PATCH 3/3] ARM: dts: Add WM1811A audio CODEC to Arndale bindings
In-Reply-To: <1372714599-17588-1-git-send-email-broonie@kernel.org>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
Message-ID: <1372714599-17588-3-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The default audio module for the Arndale has a WM811A on it. Add this to
the device tree bindings.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 482f275..75c3065 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -325,7 +325,22 @@
 	};
 
 	i2c at 12C90000 {
-		status = "disabled";
+		wm1811a at 11 {
+			compatible = "wlf,wm1811";
+			reg = <0x1a>;
+
+			AVDD2-supply = <&main_dc_reg>;
+			CPVDD-supply = <&main_dc_reg>;
+			DBVDD1-supply = <&main_dc_reg>;
+			DBVDD2-supply = <&main_dc_reg>;
+			DBVDD3-supply = <&main_dc_reg>;
+			LDO1VDD-supply = <&main_dc_reg>;
+			SPKVDD1-supply = <&main_dc_reg>;
+			SPKVDD2-supply = <&main_dc_reg>;
+
+			wlf,ldo1ena = <&gpb0 0 0>;
+			wlf,ldo2ena = <&gpb0 1 0>;
+		};
 	};
 
 	i2c at 12CA0000 {
-- 
1.8.3.1
