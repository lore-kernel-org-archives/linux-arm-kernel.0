From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:06:00 +0200
Subject: [PATCH v2 15/22] ARM: dts: exynos: Use phandle to get parent node in
 exynos5250-snow
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-16-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c-arbitrator node in exynos5250-snow-common used absolute path to
reference other node (the i2c parent). Use phandle instead, because the
depth of the other node may be changed (like moving it under 'soc'
node).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index ddfe1f558c10..419d59da1751 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -61,7 +61,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		i2c-parent = <&{/i2c@12CA0000}>;
+		i2c-parent = <&i2c_4>;
 
 		our-claim-gpio = <&gpf0 3 GPIO_ACTIVE_LOW>;
 		their-claim-gpios = <&gpe0 4 GPIO_ACTIVE_LOW>;
-- 
2.5.0
