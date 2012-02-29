From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 29 Feb 2012 15:14:41 +0100
Subject: [PATCH 1/1] ARM: at91: at91sam9x5cm/dt: add leds support
Message-ID: <1330524881-24668-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5cm.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index f4adba4..c0afd5e 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -45,6 +45,21 @@
 					reg = <0x800000 0x1f800000>;
 				};
 			};
+
+			leds {
+				compatible = "gpio-leds";
+
+				pb18 {
+					label = "pb18";
+					gpios = <&pioB 18 1>;
+					linux,default-trigger = "heartbeat";
+				};
+
+				pd21 {
+					label = "pd21";
+					gpios = <&pioD 21 0>;
+				};
+			};
 		};
 	};
 };
-- 
1.7.7
