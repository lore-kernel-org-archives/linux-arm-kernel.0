From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 20:13:35 +0100
Subject: [PATCH 1/4] ARM: at91: usb_a9g20/dt: add leds support
Message-ID: <1328469218-3208-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/usb_a9g20.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index fda27eb..27ab9bb 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -96,6 +96,17 @@
 					spi-max-frequency = <20000000>;
 				};
 			};
+
+			leds {
+				compatible = "gpio-leds";
+
+				user_led {
+					label = "user_led";
+					gpios = <&pioB 21 1>;
+					linux,default-trigger = "heartbeat";
+				};
+			};
+
 		};
 	};
 };
-- 
1.7.7
