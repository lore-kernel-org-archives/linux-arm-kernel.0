From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Wed, 8 Aug 2018 02:25:53 +0300
Subject: [PATCH 1/2] ARM: dts: sunxi: Don't use cd-inverted in
 sun8i-r40-bananapi-m2-ultra
Message-ID: <20180807232554.16825-1-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another user of cd-inverted seems to have crept in. Switch it away from
cd-inverted to be consistent with other sunxi boards.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index c39b9169ea64..a891a387e8f1 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -159,8 +159,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
-	cd-inverted;
+	cd-gpios = <&pio 7 13 GPIO_ACTIVE_LOW>; /* PH13 */
 	status = "okay";
 };
 
-- 
2.16.3
