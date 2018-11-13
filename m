From: john@metanate.com (John Keeping)
Date: Tue, 13 Nov 2018 15:24:13 +0000
Subject: [PATCH] ARM: dts: rockchip: Fix Rock2 vcc_flash name
Message-ID: <20181113152413.11386-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no functional change from this, but it is confusing to find two
copies of vcc_sys and no vcc_flash when looking in
/sys/class/regulator/*/name.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288-rock2-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index a610e592c148..b6bb58d9ff91 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -25,7 +25,7 @@
 
 	vcc_flash: flash-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
+		regulator-name = "vcc_flash";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		startup-delay-us = <150>;
-- 
2.19.1
