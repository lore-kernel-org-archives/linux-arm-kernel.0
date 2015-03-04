From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed,  4 Mar 2015 15:52:17 +0100
Subject: [PATCH 2/4] ARM: Kirkwood: add modes-map property to ns2-leds nodes
In-Reply-To: <1425480739-2373-1-git-send-email-simon.guinot@sequanux.org>
References: <1425480739-2373-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1425480739-2373-3-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Donnefort <vdonnefort@gmail.com>

Since the LED modes mapping is no longer hardcoded inside the leds-ns2
driver, then it must be provided through the modes-map property in the
ns2-leds nodes.

Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
---
 arch/arm/boot/dts/kirkwood-d2net.dts   | 5 +++++
 arch/arm/boot/dts/kirkwood-is2.dts     | 5 +++++
 arch/arm/boot/dts/kirkwood-ns2.dts     | 5 +++++
 arch/arm/boot/dts/kirkwood-ns2max.dts  | 5 +++++
 arch/arm/boot/dts/kirkwood-ns2mini.dts | 5 +++++
 5 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-d2net.dts b/arch/arm/boot/dts/kirkwood-d2net.dts
index 6b7856025001..e1c25c35e9ce 100644
--- a/arch/arm/boot/dts/kirkwood-d2net.dts
+++ b/arch/arm/boot/dts/kirkwood-d2net.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/leds-ns2.h>
 #include "kirkwood-netxbig.dtsi"
 
 / {
@@ -28,6 +29,10 @@
 			label = "d2net_v2:blue:sata";
 			slow-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 			cmd-gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
+			modes-map = <NS_V2_LED_OFF  1 0
+				     NS_V2_LED_ON   0 1
+				     NS_V2_LED_ON   1 1
+				     NS_V2_LED_SATA 0 0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/kirkwood-is2.dts
index da674bbd49a8..4121674abd1c 100644
--- a/arch/arm/boot/dts/kirkwood-is2.dts
+++ b/arch/arm/boot/dts/kirkwood-is2.dts
@@ -1,5 +1,6 @@
 /dts-v1/;
 
+#include <dt-bindings/leds/leds-ns2.h>
 #include "kirkwood-ns2-common.dtsi"
 
 / {
@@ -27,6 +28,10 @@
 			label = "ns2:blue:sata";
 			slow-gpio = <&gpio0 29 0>;
 			cmd-gpio = <&gpio0 30 0>;
+			modes-map = <NS_V2_LED_OFF  1 0
+				     NS_V2_LED_ON   0 1
+				     NS_V2_LED_ON   1 1
+				     NS_V2_LED_SATA 0 0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-ns2.dts b/arch/arm/boot/dts/kirkwood-ns2.dts
index 53368d1022cc..190189d235e6 100644
--- a/arch/arm/boot/dts/kirkwood-ns2.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2.dts
@@ -1,5 +1,6 @@
 /dts-v1/;
 
+#include <dt-bindings/leds/leds-ns2.h>
 #include "kirkwood-ns2-common.dtsi"
 
 / {
@@ -27,6 +28,10 @@
 			label = "ns2:blue:sata";
 			slow-gpio = <&gpio0 29 0>;
 			cmd-gpio = <&gpio0 30 0>;
+			modes-map = <NS_V2_LED_OFF  1 0
+				     NS_V2_LED_ON   0 1
+				     NS_V2_LED_ON   1 1
+				     NS_V2_LED_SATA 0 0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/kirkwood-ns2max.dts
index 72c78d0b1116..55cc41d9c80c 100644
--- a/arch/arm/boot/dts/kirkwood-ns2max.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2max.dts
@@ -1,5 +1,6 @@
 /dts-v1/;
 
+#include <dt-bindings/leds/leds-ns2.h>
 #include "kirkwood-ns2-common.dtsi"
 
 / {
@@ -46,6 +47,10 @@
 			label = "ns2:blue:sata";
 			slow-gpio = <&gpio0 29 0>;
 			cmd-gpio = <&gpio0 30 0>;
+			modes-map = <NS_V2_LED_OFF  1 0
+				     NS_V2_LED_ON   0 1
+				     NS_V2_LED_ON   1 1
+				     NS_V2_LED_SATA 0 0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/kirkwood-ns2mini.dts
index c441bf62c09f..9935f3ec29b4 100644
--- a/arch/arm/boot/dts/kirkwood-ns2mini.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2mini.dts
@@ -1,5 +1,6 @@
 /dts-v1/;
 
+#include <dt-bindings/leds/leds-ns2.h>
 #include "kirkwood-ns2-common.dtsi"
 
 / {
@@ -47,6 +48,10 @@
 			label = "ns2:blue:sata";
 			slow-gpio = <&gpio0 29 0>;
 			cmd-gpio = <&gpio0 30 0>;
+			modes-map = <NS_V2_LED_OFF  1 0
+				     NS_V2_LED_ON   0 1
+				     NS_V2_LED_ON   1 1
+				     NS_V2_LED_SATA 0 0>;
 		};
 	};
 };
-- 
2.1.1
