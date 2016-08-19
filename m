From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 19 Aug 2016 22:17:03 +0930
Subject: [PATCH v2 5/7] aspeed-g4: Add gpio controller to devicetree
In-Reply-To: <20160819124705.24633-1-andrew@aj.id.au>
References: <20160819124705.24633-1-andrew@aj.id.au>
Message-ID: <20160819124705.24633-6-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c2ab63c621c0..9a4a9e998e71 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -492,6 +492,15 @@
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
2.9.3
