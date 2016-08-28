From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Aug 2016 19:32:43 +0200
Subject: [PATCH 1/4] ARM: tegra: nyan: Use proper IRQ type definitions
Message-ID: <20160828173246.32621-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches a few interrupt definitions that were using
GPIO_ACTIVE_HIGH as IRQ type, which is invalid.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 271505e..30a77ec 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -59,7 +59,7 @@
 			compatible = "maxim,max98090";
 			reg = <0x10>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
+			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_FALLING>;
 		};
 
 		temperature-sensor at 4c {
@@ -325,7 +325,7 @@
 					reg = <0x9>;
 					interrupt-parent = <&gpio>;
 					interrupts = <TEGRA_GPIO(J, 0)
-							GPIO_ACTIVE_HIGH>;
+							IRQ_TYPE_EDGE_BOTH>;
 					ti,ac-detect-gpios = <&gpio
 							TEGRA_GPIO(J, 0)
 							GPIO_ACTIVE_HIGH>;
-- 
2.9.3
