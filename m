From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 30 Aug 2016 17:25:58 +0930
Subject: [PATCH v3 5/7] aspeed-g4: Add gpio controller to devicetree
In-Reply-To: <20160830075600.11559-1-andrew@aj.id.au>
References: <20160830075600.11559-1-andrew@aj.id.au>
Message-ID: <20160830075600.11559-6-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index a5d6e81e318a..7c2b73c4d5ab 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -492,6 +492,16 @@
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
 
+			gpio: gpio at 1e780000 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2400-gpio";
+				reg = <0x1e780000 0x1000>;
+				interrupts = <20>;
+				gpio-ranges = <&pinctrl 0 0 220>;
+				interrupt-controller;
+			};
+
 			timer: timer at 1e782000 {
 				compatible = "aspeed,ast2400-timer";
 				reg = <0x1e782000 0x90>;
-- 
2.9.3.1.g0db844e
