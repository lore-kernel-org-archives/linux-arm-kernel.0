From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 23 Mar 2016 15:10:17 +0900
Subject: [PATCH] ARM: dts: exynos: Enable SSS on Odroid X/X2/U3 family
Message-ID: <1458713417-32669-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Security SubSystem (SSS) on Exynos4412-based Odroid boards
to provide hardware acceleration for AES operations.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 5e5d3fecb04c..470e592e9232 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -492,6 +492,10 @@
 	status = "okay";
 };
 
+&sss {
+	status = "okay";
+};
+
 &tmu {
 	vtmu-supply = <&ldo10_reg>;
 	status = "okay";
-- 
2.5.0
