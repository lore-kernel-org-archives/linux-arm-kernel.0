From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 23 Jan 2017 15:57:45 +1030
Subject: [PATCH] aspeed: dts: g5: Update GPIO pin range to mux extra banks
Message-ID: <20170123052745.9575-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Aspeed GPIO driver recently gained support for banks Y, Z, AA, AB and AC.
Update the devicetree so GPIO requests for these pins are routed via pinmux,
else the export succeeds but the GPIOs are non-functional.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index b664fe380936..a9305b964b11 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -920,8 +920,8 @@
 				compatible = "aspeed,ast2500-gpio";
 				reg = <0x1e780000 0x1000>;
 				interrupts = <20>;
-				gpio-ranges = <&pinctrl 0 0 220>;
 				interrupt-controller;
+				gpio-ranges = <&pinctrl 0 0 232>;
 			};
 
 			timer: timer at 1e782000 {
-- 
2.9.3
