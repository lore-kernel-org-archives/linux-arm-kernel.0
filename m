From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  6 Dec 2016 14:53:44 +1100
Subject: [PATCH v4 2/6] arm: dts: aspeed-g4: Add gpio controller to devicetree
In-Reply-To: <20161206035348.29948-1-andrew@aj.id.au>
References: <20161206035348.29948-1-andrew@aj.id.au>
Message-ID: <20161206035348.29948-3-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b00dfc7a3bf7..20b75667286f 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -822,6 +822,16 @@
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
2.9.3
