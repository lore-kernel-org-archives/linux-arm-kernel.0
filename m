From: joel@jms.id.au (Joel Stanley)
Date: Mon, 12 Feb 2018 18:13:24 +1030
Subject: [PATCH 5/6] ARM: dts: palmetto: Add LEDs and GPIO keys
In-Reply-To: <20180212074325.23436-1-joel@jms.id.au>
References: <20180212074325.23436-1-joel@jms.id.au>
Message-ID: <20180212074325.23436-6-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These describe the front panel LEDs that are present on a Palmetto
chassis, and the checkstop GPIO that comes from the Power8 CPU to
indicate a host error.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index 5115247e5e59..2a4a355a779d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include "aspeed-g4.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
 	model = "Palmetto BMC";
@@ -26,6 +27,32 @@
 			reg = <0x5f000000 0x01000000>; /* 16M */
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_LOW>;
+		};
+
+		power {
+			gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_LOW>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		checkstop {
+			label = "checkstop";
+			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(P, 5)>;
+		};
+	};
 };
 
 &fmc {
-- 
2.15.1
