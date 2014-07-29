From: thomas.ab@samsung.com (Thomas Abraham)
Date: Tue, 29 Jul 2014 09:57:09 +0530
Subject: [PATCH] ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
Message-ID: <1406608029-8538-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQB interrupt pin of MAX77686 PMIC is connected to GPX3[2] pin of
Exynos5250 on the Exynos5250 SMDK board. Specify this connection using
interrupts property for the max77686 pmic node.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 695f5ad..cf38808 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -50,6 +50,8 @@
 		max77686 at 09 {
 			compatible = "maxim,max77686";
 			reg = <0x09>;
+			interrupt-parent = <&gpx3>;
+			interrupts = <2 0>;
 
 			voltage-regulators {
 				ldo1_reg: LDO1 {
-- 
1.7.9.5
