From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Sun,  4 Dec 2016 13:29:48 +0100
Subject: [PATCH] dts: sun8i-h3: correct UART3 pin definitions
Message-ID: <20161204122948.11921-1-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

In a previous commit, I made a copy/paste error in the pinmux
definitions of UART3: PG{13,14} instead of PA{13,14}. This commit takes
care of that. I have tested this commit on Orange Pi PC and Orange Pi
Plus, and it works for these boards.

Fixes: e3d11d3c45c5 ("dts: sun8i-h3: add pinmux definitions for
UART2-3")

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 75a8654..f4ba088 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -410,7 +410,7 @@
 			};
 
 			uart3_pins: uart3 {
-				allwinner,pins = "PG13", "PG14";
+				allwinner,pins = "PA13", "PA14";
 				allwinner,function = "uart3";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.9.3
