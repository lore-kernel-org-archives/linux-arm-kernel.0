From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 19 Aug 2016 22:17:05 +0930
Subject: [PATCH v2 7/7] aspeed-g5: Add gpio controller to devicetree
In-Reply-To: <20160819124705.24633-1-andrew@aj.id.au>
References: <20160819124705.24633-1-andrew@aj.id.au>
Message-ID: <20160819124705.24633-8-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

Since v1:

* Use aspeed,ast2500-gpio compatible string

 arch/arm/boot/dts/aspeed-g5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index ae5871a11a70..318e1deafe30 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -280,6 +280,15 @@
 				reg = <0x1e720000 0x9000>;	// 36K
 			};
 
+			gpio: gpio at 1e780000 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2500-gpio";
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
