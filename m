From: eric@anholt.net (Eric Anholt)
Date: Fri, 11 Nov 2016 09:38:21 -0800
Subject: [PATCH] ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED
Message-ID: <20161111173821.21491-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrea Merello <andrea.merello@gmail.com>

We are incorrectly defining the pwr LED, attaching it to a gpio line
that is wired to the Wi-Fi SDIO module (which fails due to this).

The actual power LED is connected to the GPIO expander, which we don't
expose currently.

Thanks-to: Eric Anholt <eric@anholt.net> [for clarifying we can't control the LED]
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 7625e57a64b5..c309633a1e87 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -16,13 +16,6 @@
 		act {
 			gpios = <&gpio 47 0>;
 		};
-
-		pwr {
-			label = "PWR";
-			gpios = <&gpio 35 0>;
-			default-state = "keep";
-			linux,default-trigger = "default-on";
-		};
 	};
 };
 
-- 
2.10.2
