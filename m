From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 22 Jan 2017 16:47:48 +0100
Subject: [PATCH v2 1/6] ARM: tegra: nyan: Use proper IRQ type definitions
Message-ID: <20170122154753.31942-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches a few interrupt definitions that were using
GPIO_ACTIVE_HIGH as IRQ type, which is invalid.

This is mostly a cosmetic change, that doesn't affect any driver.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index eabfa655a3cd..ef430aa30152 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -65,7 +65,7 @@
 			compatible = "maxim,max98090";
 			reg = <0x10>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
+			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_FALLING>;
 		};
 
 		temperature-sensor at 4c {
@@ -331,7 +331,7 @@
 					reg = <0x9>;
 					interrupt-parent = <&gpio>;
 					interrupts = <TEGRA_GPIO(J, 0)
-							GPIO_ACTIVE_HIGH>;
+							IRQ_TYPE_EDGE_BOTH>;
 					ti,ac-detect-gpios = <&gpio
 							TEGRA_GPIO(J, 0)
 							GPIO_ACTIVE_HIGH>;
-- 
2.11.0
