From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:34 +0100
Subject: [PATCH 33/77] ARM: dts: sun6i: colombus: Change i2c node name to
 avoid warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <c89c360f86fcbc48d9e11fdb02ba2d65245a4643.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our I2C GPIO bus node name has a unit address, but no reg property, which
generates a warning in DTC. Change the name to remove that unit address.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 99f25b2d5189..6aa3f5d074bd 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -60,7 +60,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	i2c_lcd: i2c at 0 {
+	i2c_lcd: i2c {
 		/* The lcd panel i2c interface is hooked up via gpios */
 		compatible = "i2c-gpio";
 		pinctrl-names = "default";
-- 
git-series 0.9.1
