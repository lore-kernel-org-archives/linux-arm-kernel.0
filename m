From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 20:13:37 +0100
Subject: [PATCH 3/4] ARM: at91: at91sam9m10g45ek/dt: add gpio-keys support
In-Reply-To: <1328469218-3208-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328469218-3208-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328469218-3208-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   51 ++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 112feba..e995fba 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -102,6 +102,57 @@
 				};
 			};
 
+			gpio_keys {
+				compatible = "gpio-keys";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				left_click {
+					label = "left_click";
+					gpios = <&pioB 6 1>;
+					linux,code = <272>;
+					gpio-key,wakeup;
+				};
+
+				right_click {
+					label = "right_click";
+					gpios = <&pioB 7 1>;
+					linux,code = <273>;
+					gpio-key,wakeup;
+				};
+
+				left {
+					label = "Joystick Left";
+					gpios = <&pioB 14 1>;
+					linux,code = <105>;
+				};
+
+				right {
+					label = "Joystick Right";
+					gpios = <&pioB 15 1>;
+					linux,code = <106>;
+				};
+
+				up {
+					label = "Joystick Up";
+					gpios = <&pioB 16 1>;
+					linux,code = <103>;
+				};
+
+				down {
+					label = "Joystick Down";
+					gpios = <&pioB 17 1>;
+					linux,code = <108>;
+				};
+
+				enter {
+					label = "Joystick Press";
+					gpios = <&pioB 18 1>;
+					linux,code = <28>;
+				};
+
+			};
+
 		};
 	};
 
-- 
1.7.7
