From: simon@lineageos.org (Simon Shields)
Date: Tue, 21 Nov 2017 22:24:24 +1100
Subject: [PATCH] ARM: dts: exynos: correct trats2 panel reset line
Message-ID: <20171121112424.GA6650@lineageos.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

trats2 uses gpf2-1 as the panel reset GPIO. gpy4-5 was only used
on early revisions of the board.

Fixes: 420ae8451a22 ("ARM: dts: exynos4412-trats2: add panel node")
Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 220cdf109405..9f4672ba9943 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -454,7 +454,7 @@
 		reg = <0>;
 		vdd3-supply = <&lcd_vdd3_reg>;
 		vci-supply = <&ldo25_reg>;
-		reset-gpios = <&gpy4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpf2 1 GPIO_ACTIVE_HIGH>;
 		power-on-delay= <50>;
 		reset-delay = <100>;
 		init-delay = <100>;
-- 
2.15.0
