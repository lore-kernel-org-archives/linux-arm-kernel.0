From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 16 Jul 2018 18:59:19 +0200
Subject: [PATCH] arm64: dts: rockchip: drop out-of-tree properties from
 rk3399-ficus regulator
Message-ID: <20180716165919.10744-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-regulator for vdd_log uses additional unreviewed properties in the
vendor kernel, which slipped in with the devicetree.
As written, they are unreviewed and unused in all mainline implementations
so drop them again.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Already applied and just for reference.

 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 6295483b701f..8978d924eb83 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -84,11 +84,6 @@
 		regulator-max-microvolt = <1400000>;
 		regulator-always-on;
 		regulator-boot-on;
-
-		/* for rockchip boot on */
-		rockchip,pwm_id= <2>;
-		rockchip,pwm_voltage = <900000>;
-
 		vin-supply = <&vcc_sys>;
 	};
 
-- 
2.17.0
