From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 20 Jul 2016 15:28:31 +0930
Subject: [PATCH 10/12] aspeed-g4: Add gpio controller to devicetree
In-Reply-To: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
Message-ID: <1468994313-13538-11-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index a62d1b5b5054..2b7da0fdfbd9 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -356,6 +356,15 @@
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
 
+			gpio: gpio at 1e780000 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2400-gpio";
+				reg = <0x1e780000 0x1000>;
+				interrupts = <20>;
+				gpio-ranges = <&pinctrl 0 0 220>;
+			};
+
 			timer: timer at 1e782000 {
 				compatible = "aspeed,ast2400-timer";
 				reg = <0x1e782000 0x90>;
-- 
2.7.4
