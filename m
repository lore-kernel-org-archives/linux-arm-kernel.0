From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Apr 2018 19:34:18 +0800
Subject: [PATCH 1/7] ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2
 regulator voltage
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Message-ID: <20180424113424.13196-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltage of the VCC-1V2 regulator on the ALL-H3-CC H3 ver. should be
1.2V, not the 3.3V currently defined in the device tree.

Fix the voltage in the device tree.

Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
		      Computer Board ALL-H3-CC H3 ver.")
Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index 5971b8b0b768..db6b35bb65ff 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -62,8 +62,8 @@
 	reg_vcc1v2: vcc1v2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v2";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
 		regulator-always-on;
 		regulator-boot-on;
 		vin-supply = <&reg_vcc5v0>;
-- 
2.17.0
