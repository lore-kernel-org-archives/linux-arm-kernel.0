From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 29 Apr 2015 10:00:27 +0200
Subject: [PATCH 1/4] ARM: dts: sunxi: sun5i: add spi2_pins_b.
In-Reply-To: <cover.1430295711.git.hramrach@gmail.com>
References: <cover.1430295711.git.hramrach@gmail.com>
Message-ID: <bda468ecf45ca063098f756bdaba85b6f5f42263.1430295711.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi2_pins_a are only available on A10s

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 186d25f..9f22c28 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -551,6 +551,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 			};
+
+			spi2_pins_b: spi2 at 1 {
+				allwinner,pins = "PE00", "PE01", "PE02", "PE03";
+				allwinner,function = "spi2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.1.4
