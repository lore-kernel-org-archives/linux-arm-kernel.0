From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 18 Jul 2018 12:59:27 +0000
Subject: [PATCHv2] ARM: dts: exynos5: add missing interrupts for pwm node
Message-ID: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing GIC interrupts property for pwm nodes.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Fixed the patch indentation issue with all tabs.
sorry checkpatch could not figure out the error.
---
 arch/arm/boot/dts/exynos5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 5d2f0a0..f48fb9b 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -169,6 +169,11 @@
 		pwm: pwm at 12dd0000 {
 			compatible = "samsung,exynos4210-pwm";
 			reg = <0x12DD0000 0x100>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
 			#pwm-cells = <3>;
 		};
-- 
2.7.4
